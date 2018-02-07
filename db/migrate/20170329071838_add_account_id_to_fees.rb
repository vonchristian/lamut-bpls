class AddAccountIdToFees < ActiveRecord::Migration[5.1]
  def change
    add_reference :fees, :account, foreign_key: true, type: :uuid
  end
end
