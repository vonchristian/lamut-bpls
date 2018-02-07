class AddApproverToBusinessPermitApprovals < ActiveRecord::Migration[5.1]
  def change
    add_reference :business_permit_approvals, :approver, foreign_key: { to_table: :users }, type: :uuid
  end
end
