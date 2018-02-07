class CreatePermitApplicationDateRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :permit_application_date_ranges, id: :uuid do |t|
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
