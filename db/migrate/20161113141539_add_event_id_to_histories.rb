class AddEventIdToHistories < ActiveRecord::Migration
  def change
    add_reference :histories, :event, index: true, foreign_key: true
  end
end
