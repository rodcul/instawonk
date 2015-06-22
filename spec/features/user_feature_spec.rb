require "rails_helper"

feature 'User' do
  before do
    User.create(username: 'AhIsCool',
                full_name: 'Alex Handy',
                bio: 'Cooler than you megalolz',
                follows: '0',
                followed_by: '1000000000')
  end
  scenario 'visits homepage and sees top user details' do
    visit('/users')
    expect(page).to have_content('AhIsCool')
    expect(page).to have_content('Alex Handy')
    expect(page).to have_content('Cooler than you megalolz')
    expect(page).to have_content('0')
    expect(page).to have_content('1000000000')
  end
end