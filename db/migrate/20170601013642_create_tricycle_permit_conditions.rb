class CreateTricyclePermitConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :tricycle_permit_conditions, id: :uuid do |t|
      t.belongs_to :tricycle_permit_approval, foreign_key: true, type: :uuid
      t.belongs_to :permit_condition, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
