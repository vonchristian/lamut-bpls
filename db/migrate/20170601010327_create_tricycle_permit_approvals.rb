class CreateTricyclePermitApprovals < ActiveRecord::Migration[5.1]
  def change
    create_table :tricycle_permit_approvals, id: :uuid do |t|
      t.datetime :date_approved
      t.string :permit_number 
      t.belongs_to :tricycle_permit_application, foreign_key: true, type: :uuid, index: { name: "index_on_tricycle_permit_approvals_permit_application"}
      t.belongs_to :user, foreign_key: true, type: :uuid

      t.string :remarks

      t.timestamps
    end
  end
end
