class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :street_number
      t.string :house_number
      t.string :city
      t.string :zip_code

      t.timestamps null: false
    end
  end
end
