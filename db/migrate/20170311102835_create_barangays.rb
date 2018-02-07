class CreateBarangays < ActiveRecord::Migration[5.1]
  def change
    create_table :barangays, id: :uuid do |t|
      t.belongs_to :municipality_or_city, foreign_key: true, type: :uuid
      t.string :name

      t.timestamps
    end
    add_index :barangays, [:municipality_or_city_id, :name], unique: true
  end
end
