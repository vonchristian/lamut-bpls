class AddAccountsToTricycleFees < ActiveRecord::Migration[5.1]
  def change
    add_reference :tricycle_fees, :debit_account, foreign_key: { to_table: :accounts }, type: :uuid
    add_reference :tricycle_fees, :credit_account, foreign_key: { to_table: :accounts }, type: :uuid
  end
end
