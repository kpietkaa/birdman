class Animal < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :animal_type, :user
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
