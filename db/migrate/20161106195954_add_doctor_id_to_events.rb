class AddDoctorIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :doctor_id, :integer
  end
end
