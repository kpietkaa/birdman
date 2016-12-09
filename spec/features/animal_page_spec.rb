require 'rails_helper'
require_relative '../support/feature_helpers'
require "cancan/matchers"

feature "animal page" do
  scenario "user's animal page" do
    sign_in_admin

    animal = FactoryGirl.create(:animal, user: @user)
    animal.user_id = @user.id
    visit("/animals/#{animal.id}")

    expect(page).to have_content('Reksio')
  end
end
