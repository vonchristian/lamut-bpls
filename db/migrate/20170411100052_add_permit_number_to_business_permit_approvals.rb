class AddPermitNumberToBusinessPermitApprovals < ActiveRecord::Migration[5.1]
  def change
    add_column :business_permit_approvals, :permit_number, :string
    add_index :business_permit_approvals, :permit_number, unique: true
  end
end
