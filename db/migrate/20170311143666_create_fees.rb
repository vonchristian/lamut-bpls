class CreateFees < ActiveRecord::Migration[5.1]
  def change
    create_table :fees, id: :uuid do |t|
      t.string :name
      t.decimal :amount
      t.boolean :default_fee, default: false

      t.timestamps
    end
    add_index :fees, :name, unique: true
  end
end
