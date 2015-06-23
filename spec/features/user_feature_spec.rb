require "rails_helper"

feature 'User' do
  before do
    User.create(username: 'AhIsCool',
                full_name: 'Alex Handy',
                bio: 'Cooler than you megalolz',
                follows: '0',
                followed_by: '1000000000')
    User.create(username: 'AmIsBetter',
                full_name: 'Ashleigh',
                bio: 'The coolest everrrr',
                follows: '0',
                followed_by: '1000000001')
  end
  scenario 'visits homepage and sees user details' do
    visit('/')
    expect(page).to have_content('AhIsCool')
    expect(page).to have_content('Alex Handy')
    expect(page).to have_content('Cooler than you megalolz')
    expect(page).to have_content('0')
    expect(page).to have_content('1000000000')
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
    fill_in 'Search', with: 'coolest'
    click_button 'Search'
    expect(page).to have_content 'The coolest everrrr'
    expect(page).to have_content 'Ashleigh'
    expect(page).not_to have_content 'Cooler than you megalolz'
    expect(page).not_to have_content 'Alex Handy'
  end

# The following isn't passing... yet!
  # scenario 'can search a term in capitals and will output a user with that term in bio regardless of state' do
  #   visit '/'
  #   fill_in 'Search', with: 'COOLEST'
  #   click_button 'Search'
  #   expect(page).to have_content 'The coolest everrrr'
  #   expect(page).to have_content 'Ashleigh'
  #   expect(page).not_to have_content 'Cooler than you megalolz'
  #   expect(page).not_to have_content 'Alex Handy'
  # end
end