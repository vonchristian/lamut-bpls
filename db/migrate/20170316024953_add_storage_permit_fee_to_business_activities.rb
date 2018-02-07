class AddStoragePermitFeeToBusinessActivities < ActiveRecord::Migration[5.1]
  def change
    add_reference :business_activities, :storage_permit_fee, foreign_key: true, type: :uuid
  end
end
