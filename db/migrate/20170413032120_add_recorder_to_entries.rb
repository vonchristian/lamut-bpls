class AddRecorderToEntries < ActiveRecord::Migration[5.1]
  def change
    add_reference :entries, :user, foreign_key: true, type: :uuid
  end
end
