FactoryGirl.define do
  factory :event do
    start_at "2016-11-01 18:38:44"
    end_at "2016-11-01 18:38:44"
    event_type "MyString"
    doctor_id 1
    animal_id 1
  end
end
