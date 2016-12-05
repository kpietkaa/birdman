require 'rails_helper'

feature 'create new animal' do
  scenario 'with valid data' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    visit('/')
    click_on('Add Animal')

    fill_in('Name', with: 'Reksio')
    select('Dog', from: 'Animal type')
    fill_in('Breed', with: 'White')
    choose 'Male'
    choose 'Yes'
    click_on('Create Animal')

    expect(page).to have_content('Animal has been created')
    expect(Animal.last.name).to eq('Reksio')
  end

  scenario "with invalid data" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    
    visit('/')
    click_on('Add Animal')

    click_on('Create Animal')

    expect(page).to have_content("can't be blank")
  end
end
