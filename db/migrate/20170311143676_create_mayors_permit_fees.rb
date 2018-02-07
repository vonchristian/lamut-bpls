class CreateMayorsPermitFees < ActiveRecord::Migration[5.1]
  def change
    create_table :mayors_permit_fees, id: :uuid do |t|
      t.belongs_to :line_of_business, foreign_key: true, type: :uuid
      t.decimal :amount

      t.timestamps
    end
  end
end
