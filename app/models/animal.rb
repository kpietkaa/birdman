class Animal < ActiveRecord::Base
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
