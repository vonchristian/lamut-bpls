class CreateAmounts < ActiveRecord::Migration[5.1]
  def change
    create_table :amounts, id: :uuid do |t|
      t.string :type
      t.references :account, foreign_key: true, type: :uuid
      t.references :entry, foreign_key: true, type: :uuid
      t.decimal :amount

      t.timestamps
    end
    add_index :amounts, :type
  end
end
