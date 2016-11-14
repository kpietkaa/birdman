class AddSurgeryToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :surgery, :text
  end
end
