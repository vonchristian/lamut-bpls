class AddCalendarYearToSurcharges < ActiveRecord::Migration[5.1]
  def change
    add_column :surcharges, :calendar_year, :datetime
  end
end
