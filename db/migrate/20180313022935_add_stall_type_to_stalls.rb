class AddStallTypeToStalls < ActiveRecord::Migration[5.1]
  def change
    add_column :stalls, :stall_type, :integer
    add_index :stalls, :stall_type
  end
end
