class CreateTricyclePermitApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :tricycle_permit_applications, id: :uuid do |t|
      t.integer :transaction_type
      t.belongs_to :tricycle, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
