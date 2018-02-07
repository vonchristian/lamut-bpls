class CreateFareAdjustmentFees < ActiveRecord::Migration[5.1]
  def change
    create_table :fare_adjustment_fees, id: :uuid do |t|
      t.belongs_to :tricycle, foreign_key: true, type: :uuid
      t.decimal :amount
      t.date :calendar_year

      t.timestamps
    end
  end
end
