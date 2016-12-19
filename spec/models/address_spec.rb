require 'rails_helper'

RSpec.describe Address, type: :model do

  describe "validates" do
    it "create complete street address" do
      street = Address.new(street: 'Test', street_number: '12', house_number: '99a')
      expect(street.street_address).to include('Test 12/99a')
    end

    it "concatenation zip code with city" do
      zip_city = Address.new(zip_code: '33-333', city: 'Silicon Valley')
      expect(zip_city.zip_city).to include('33-333 Silicon Valley')
    end
  end
end
