class AddUserIdToAnimals < ActiveRecord::Migration
  def change
    add_reference :animals, :user, index: true, foreign_key: true
  end
end
