require 'rails_helper'

feature 'home page' do
  scenario 'welcome message' do
    visit('/')
    expect(page).to have_content('Your Favorite Veterinary Clinic in Wrocław')
  end
end
