FactoryGirl.define do
  factory :user do
    email 'test@examle.com'
    password '123456'
    first_name 'test'
    last_name 'test'
  end
end
