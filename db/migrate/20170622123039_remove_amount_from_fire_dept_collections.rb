class RemoveAmountFromFireDeptCollections < ActiveRecord::Migration[5.1]
  def change
    remove_column :fire_dept_collections, :amount, :decimal
  end
end
