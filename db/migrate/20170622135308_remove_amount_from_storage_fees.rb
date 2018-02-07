class RemoveAmountFromStorageFees < ActiveRecord::Migration[5.1]
  def change
    remove_column :storage_fees, :amount, :decimal
  end
end
