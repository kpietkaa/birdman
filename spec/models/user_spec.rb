require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it "requires emails to be unique for users" do
      user1 = User.create(email: 'test@test.com', password: '123456', first_name: 'test', last_name: 'test')
      user2 = User.create(email: 'test@test.com', password: '123456', first_name: 'test', last_name: 'test')
      expect(user2.valid?).to be_falsy
    end

  end
end
