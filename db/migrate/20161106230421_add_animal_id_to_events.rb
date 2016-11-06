class AddAnimalIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :animal_id, :integer
  end
end
