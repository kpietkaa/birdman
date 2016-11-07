class CreateVisitTypes < ActiveRecord::Migration
  def change
    create_table :visit_types do |t|
      t.string :title
      t.integer :duration
      t.decimal :price

      t.timestamps null: false
    end
  end
end
