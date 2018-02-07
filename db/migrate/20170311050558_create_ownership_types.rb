class CreateOwnershipTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :ownership_types, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :ownership_types, :name, unique: true
  end
end
