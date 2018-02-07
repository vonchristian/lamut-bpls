class RemoveNumberOfUnitsFromLineOfBusinesses < ActiveRecord::Migration[5.1]
  def change
    remove_column :line_of_businesses, :number_of_units, :decimal
  end
end
