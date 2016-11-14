class ChangeDescriptionTypeInHistories < ActiveRecord::Migration
  def change
    change_column :histories, :description, :text
  end
end
