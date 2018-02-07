class AddPaidToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :paid, :boolean, default: false
  end
end
