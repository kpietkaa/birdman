class Address < ActiveRecord::Base
  has_one :user
  validates :phone_number, :street, :street_number, presence: true
  validates :phone_number, numericality: { only_integer: true }
  validates :phone_number, format: { with: /\b\d{9}\b/, message: "Invalid Phone Number, should be 123456789" }
  validates :zip_code, format: { with: /\A\d{2}-\d{3}\z/, message: "Invalid Zip Code, should be 12-345" }

  def street_address
    self.street + ' ' + self.street_number.to_s + '/' + (self.house_number.empty? ? '' : self.house_number.to_s)
  end

  def zip_city
    self.zip_code + ' ' + self.city
  end
end
