class CreateSanitaryInspectionFees < ActiveRecord::Migration[5.1]
  def change
    create_table :sanitary_inspection_fees, id: :uuid do |t|
      t.decimal :minimum_area
      t.decimal :maximum_area
      t.decimal :amount
      t.timestamps
    end
  end
end
