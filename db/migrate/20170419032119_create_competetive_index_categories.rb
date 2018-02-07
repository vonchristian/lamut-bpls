class CreateCompetetiveIndexCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :competetive_index_categories, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :competetive_index_categories, :name, unique: true
  end
end
