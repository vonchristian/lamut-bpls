class CreateTricycleRequirementVerifications < ActiveRecord::Migration[5.1]
  def change
    create_table :tricycle_requirement_verifications, id: :uuid do |t|
      t.belongs_to :applicable_tricycle_requirement, foreign_key: true, type: :uuid, index: { name: "index_on_tricycle_requirements_verifications_app_requirements"}
      t.datetime :verification_date
      t.belongs_to :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
