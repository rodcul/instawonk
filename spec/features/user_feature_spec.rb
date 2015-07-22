require 'rails_helper'

feature 'User' do
  before do
    100.times { create(:user) }
    create(:user,
           username: 'AhIsCool',
           full_name: 'Alex Handy',
           bio: 'Cooler than you megalolz',
           followed_by: '1000000000')
    create(:user,
           username: 'AmIsBetter',
           full_name: 'Ashleigh',
           bio: 'The coolest EVER',
           followed_by: '1000000001')
  end
  scenario 'visits homepage and sees user details' do
    visit('/')
    expect(page).to have_content('AhIsCool')
    expect(page).to have_content('Alex Handy')
    expect(page).to have_content('Cooler than you megalolz')
    expect(page).to have_content('0')
    expect(page).to have_content('1,000,000,000')
  end
  scenario 'shows total count of users' do
    visit('/')
    expect(page).to have_content('Showing 1 - 100 of 102')
  end

  scenario 'users are sorted by "followed by"' do
    visit '/'
    within('table.table tbody tr:nth-child(1)') do
      expect(page).to have_content 'Ashleigh'
    end
  end

  scenario 'can follow a link to the user\'s instagram page' do
    visit '/'
    expect(page).to have_selector "a[href='https://instagram.com/AhIsCool']"
  end

  scenario 'can search a term and will output a user with that term in bio' do
    visit '/'
    fill_in 'search', with: 'coolest'
    click_button 'Search'
    expect(page).to have_content 'The coolest EVER'
    expect(page).to have_content 'Ashleigh'
    expect(page).not_to have_content 'Cooler than you megalolz'
    expect(page).not_to have_content 'Alex Handy'
  end

  scenario 'can take an uppercase search term and return lowercase bios that match' do
    visit '/'
    fill_in 'search', with: 'COOLEST'
    click_button 'Search'
    expect(page).to have_content 'The coolest EVER'
    expect(page).to have_content 'Ashleigh'
    expect(page).not_to have_content 'Cooler than you megalolz'
    expect(page).not_to have_content 'Alex Handy'
  end

  scenario 'can take a lowercase search term and return uppercase bios that match' do
    visit '/'
    fill_in 'search', with: 'ever'
    click_button 'Search'
    expect(page).to have_content 'The coolest EVER'
    expect(page).to have_content 'Ashleigh'
    expect(page).not_to have_content 'Cooler than you megalolz'
    expect(page).not_to have_content 'Alex Handy'
  end

  scenario 'can take a search term in lowercase and return bio with one letter capitalised' do
    visit '/'
    fill_in 'search', with: 'cooler'
    click_button 'Search'
    expect(page).not_to have_content 'The coolest EVER'
    expect(page).not_to have_content 'Ashleigh'
    expect(page).to have_content 'Cooler than you megalolz'
    expect(page).to have_content 'Alex Handy'
  end

  context 'sorting results' do
    before do
      User.create(username: 'AhIsCool',
                  full_name: 'Alex Handy',
                  bio: 'Cooler than you megalolz',
                  follows: '0',
                  followed_by: '1000000000',
                  instagram_id: 1001)
      User.create(username: 'AmIsBetter',
                  full_name: 'Ashleigh',
                  bio: 'The coolest EVER',
                  follows: '0',
                  followed_by: '1000000001',
                  instagram_id: 1002)
      User.create(username: 'FaIsSweeter',
                  full_name: 'Fiona',
                  bio: 'The sweetest ever',
                  follows: '0',
                  followed_by: '1000000002',
                  instagram_id: 1003)
    end

    scenario 'returns search results in descending followers order' do
      visit '/'
      fill_in 'search', with: 'ever'
      click_button 'Search'
      within('table.table tbody tr:nth-child(1)') do
        expect(page).to have_content 'Fiona'
      end
      expect(page).not_to have_content 'Cooler than you megalolz'
      expect(page).not_to have_content 'Alex Handy'
    end
  end
end
