class CreateFireSafetyInspectionFeeCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :fire_safety_inspection_fee_collections, id: :uuid do |t|
      t.datetime :date
      t.string :reference_number
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.decimal :amount

      t.timestamps
    end
  end
end
