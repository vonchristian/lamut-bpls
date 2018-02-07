class AddStatusToTricycles < ActiveRecord::Migration[5.1]
  def change
    add_column :tricycles, :status, :integer
    add_index :tricycles, :status
  end
end
