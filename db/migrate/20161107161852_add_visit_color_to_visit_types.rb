class AddVisitColorToVisitTypes < ActiveRecord::Migration
  def change
    add_column :visit_types, :color, :string
  end
end
