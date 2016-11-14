class AddRecipeToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :recipe, :text
  end
end
