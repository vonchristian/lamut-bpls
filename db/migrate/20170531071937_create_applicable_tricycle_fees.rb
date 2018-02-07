class CreateApplicableTricycleFees < ActiveRecord::Migration[5.1]
  def change
    create_table :applicable_tricycle_fees, id: :uuid do |t|
      t.belongs_to :tricycle_fee, foreign_key: true, type: :uuid
      t.belongs_to :tricycle, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
