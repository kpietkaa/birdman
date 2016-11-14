class AddHistoryIdToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :history, index: true, foreign_key: true
  end
end
