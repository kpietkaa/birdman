module FeatureHelpers
  def sign_in
    @user = FactoryGirl.create(:user)
    visit('/')
    click_on('Sign In')
    fill_in('user_email', with: @user.email)
    fill_in('user_password', with: @user.password)
    click_on('Log in')
  end

  def sign_in_admin
    @user = FactoryGirl.create(:admin)
    visit('/')
    click_on('Sign In')
    fill_in('user_email', with: @user.email)
    fill_in('user_password', with: @user.password)
    click_on('Log in')
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, :type => :feature
end
