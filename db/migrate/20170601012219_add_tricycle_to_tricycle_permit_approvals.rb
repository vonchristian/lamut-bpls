class AddTricycleToTricyclePermitApprovals < ActiveRecord::Migration[5.1]
  def change
    add_reference :tricycle_permit_approvals, :tricycle, foreign_key: true, type: :uuid
  end
end
