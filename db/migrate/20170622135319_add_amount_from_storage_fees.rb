class AddAmountFromStorageFees < ActiveRecord::Migration[5.1]
  def change
    add_column :storage_fees, :amount, :decimal, default: 0
  end
end
