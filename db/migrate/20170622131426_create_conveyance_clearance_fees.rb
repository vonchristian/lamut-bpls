class CreateConveyanceClearanceFees < ActiveRecord::Migration[5.1]
  def change
    create_table :conveyance_clearance_fees, id: :uuid do |t|
      t.decimal :amount, default: 0
      t.belongs_to :fire_dept_collection, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
