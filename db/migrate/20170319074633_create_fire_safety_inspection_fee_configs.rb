class CreateFireSafetyInspectionFeeConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :fire_safety_inspection_fee_configs, id: :uuid do |t|
      t.integer :fee_type
      t.decimal :amount
      t.decimal :percent

      t.timestamps
    end
  end
end
