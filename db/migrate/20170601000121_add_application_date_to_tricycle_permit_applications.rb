class AddApplicationDateToTricyclePermitApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :tricycle_permit_applications, :application_date, :datetime
    add_column :tricycle_permit_applications, :application_number, :string
  end
end
