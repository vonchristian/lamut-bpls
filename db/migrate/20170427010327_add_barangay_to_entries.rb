class AddBarangayToEntries < ActiveRecord::Migration[5.1]
  def change
    add_reference :entries, :barangay, foreign_key: true, type: :uuid
  end
end
