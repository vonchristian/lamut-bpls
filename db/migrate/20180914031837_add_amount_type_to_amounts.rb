class AddAmountTypeToAmounts < ActiveRecord::Migration[5.1]
  def change
    add_column :amounts, :amount_type, :integer
    add_index :amounts, :amount_type
  end
end
