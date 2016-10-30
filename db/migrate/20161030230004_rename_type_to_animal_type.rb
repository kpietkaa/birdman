class RenameTypeToAnimalType < ActiveRecord::Migration
  def change
    rename_column :animals, :type, :animal_type
  end
end
