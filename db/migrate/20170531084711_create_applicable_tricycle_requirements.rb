class CreateApplicableTricycleRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :applicable_tricycle_requirements, id: :uuid do |t|
      t.belongs_to :tricycle_requirement, foreign_key: true, type: :uuid, index: { name: "index_on_tricycle_requirements_applicable_requirements"}
      t.belongs_to :tricycle, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
