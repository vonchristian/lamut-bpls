class AddDebitAccountToFees < ActiveRecord::Migration[5.1]
  def change
    add_reference :fees, :debit_account, foreign_key: { to_table: :accounts }, type: :uuid
    add_reference :fees, :credit_account, foreign_key: { to_table: :accounts }, type: :uuid
  end
end
