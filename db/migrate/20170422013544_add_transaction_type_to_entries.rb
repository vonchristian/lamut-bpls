class AddTransactionTypeToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :transaction_type, :integer
  end
end
