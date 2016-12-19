require 'rails_helper'

RSpec.describe Animal, type: :model do

  describe "validations" do
    it 'requires name' do
      animal = Animal.new(name: '')
      animal.valid?
      expect(animal.errors[:name]).not_to be_empty
    end

    it "allows different user to have animals with identical names" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      first_anmial = FactoryGirl.create(:animal, animal_type: 3, user: user1)
      new_animal = FactoryGirl.create(:animal, animal_type: 3, user: user2)
      expect(new_animal.valid?).to be_truthy
    end

    it 'belongs to user' do
      animal = Animal.new(name: 'Reksio', animal_type: 1, user: nil)
      expect(animal.valid?).to be_falsy
    end

    it 'has belongs_to user association' do
      u = Animal.reflect_on_association(:user)
      expect(u.macro).to eq(:belongs_to)
    end
  end
end
