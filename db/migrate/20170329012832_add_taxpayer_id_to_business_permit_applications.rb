class AddTaxpayerIdToBusinessPermitApplications < ActiveRecord::Migration[5.1]
  def change
    add_reference :business_permit_applications, :taxpayer, foreign_key: true, type: :uuid
  end
end
