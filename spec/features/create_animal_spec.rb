require 'rails_helper'
require_relative '../support/new_animal_form'

feature 'create new animal' do
  before do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
  end

  let(:new_animal_form) { NewAnimalForm.new }

  scenario 'with valid data' do
    new_animal_form.visit_page.fill_in_with(
      name: 'Reksio'
    ).submit

    expect(page).to have_content('Animal has been created')
    expect(Animal.last.name).to eq('Reksio')
  end

  scenario "with invalid data" do
    new_animal_form.visit_page.submit  
    expect(page).to have_content("can't be blank")
  end
end
