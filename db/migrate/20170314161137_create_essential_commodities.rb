class CreateEssentialCommodities < ActiveRecord::Migration[5.1]
  def change
    create_table :essential_commodities, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :essential_commodities, :name, unique: true
  end
end
