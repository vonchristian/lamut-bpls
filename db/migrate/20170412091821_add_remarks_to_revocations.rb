class AddRemarksToRevocations < ActiveRecord::Migration[5.1]
  def change
    add_column :revocations, :remarks, :text
  end
end
