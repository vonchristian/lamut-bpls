class CreateStoragePermitFees < ActiveRecord::Migration[5.1]
  def change
    create_table :storage_permit_fees, id: :uuid do |t|
      t.string :name
      t.decimal :amount
      t.decimal :minimum_value
      t.decimal :maximum_value

      t.timestamps
    end
  end
end
