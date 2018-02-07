class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses, id: :uuid do |t|
      t.belongs_to :barangay, foreign_key: true, type: :uuid
      t.belongs_to :municipality_or_city, foreign_key: true, type: :uuid
      t.belongs_to :province, foreign_key: true, type: :uuid
      t.string :street
      t.references :addressable, polymorphic: true, index: true, type: :uuid
      t.timestamps
    end
  end
end
