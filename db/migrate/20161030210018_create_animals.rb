class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :type
      t.string :breed
      t.boolean :sex
      t.integer :castration
      t.date :birth_date

      t.timestamps null: false
    end
  end
end
