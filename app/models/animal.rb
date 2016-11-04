class Animal < ActiveRecord::Base
  belongs_to :user
  enum animal_type: [
    :dog,
    :cat,
    :reptile,
    :bird,
    :rabbit,
    :guinea_pig,
    :other
  ]
end
