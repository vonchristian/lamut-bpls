class AddHasStoragePermitFeeToLineOfBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :line_of_businesses, :has_storage_permit_fee, :boolean, default: false
    add_column :business_activities, :volume, :decimal
  end
end
