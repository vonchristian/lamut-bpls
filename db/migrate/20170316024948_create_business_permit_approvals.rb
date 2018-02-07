class CreateBusinessPermitApprovals < ActiveRecord::Migration[5.1]
  def change
    create_table :business_permit_approvals, id: :uuid do |t|
      t.datetime :date_approved
      t.belongs_to :business_permit_application, foreign_key: true, type: :uuid, index: { name: "index_permit_approvals_on_permit_application_id"}
      t.text :remarks

      t.timestamps
    end
  end
end
