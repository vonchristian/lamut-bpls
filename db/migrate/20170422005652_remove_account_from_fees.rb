class RemoveAccountFromFees < ActiveRecord::Migration[5.1]
  def change
    remove_reference :fees, :account, foreign_key: true
  end
end
