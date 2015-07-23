require 'rails_helper'

feature 'SEO' do

  context 'onpage' do
    scenario 'meta tags for yoga search page' do
      50.times { create(:user) }
      visit('/users?search=yoga')
      expect(page).to have_content('Yoga on Instagram')
      expect(page).to have_title 'Yoga on Instagram | Instawonk'
    end
  end
end
