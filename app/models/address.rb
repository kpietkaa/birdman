class Address < ActiveRecord::Base
  has_one :user

  def street_address
    self.street + ' ' + self.street_number.to_s + '/' + (self.house_number.empty? ? '' : self.house_number.to_s)
  end

  def zip_city
    self.zip_code + ' ' + self.city
  end
end
