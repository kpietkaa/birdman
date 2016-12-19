FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com"}
    password '123456'
    first_name 'test'
    last_name 'test'

    factory :admin do
      role 'admin'
    end
  end
end
