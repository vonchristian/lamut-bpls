class AddNumberOfUnitsToLineOfBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :line_of_businesses, :number_of_units, :decimal, default: 1
  end
end
