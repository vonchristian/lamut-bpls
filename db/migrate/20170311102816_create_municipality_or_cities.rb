class CreateMunicipalityOrCities < ActiveRecord::Migration[5.1]
  def change
    create_table :municipality_or_cities, id: :uuid do |t|
      t.belongs_to :province, foreign_key: true, type: :uuid
      t.string :name

      t.timestamps
    end
    add_index :municipality_or_cities, [:province_id, :name], unique: true
  end
end
