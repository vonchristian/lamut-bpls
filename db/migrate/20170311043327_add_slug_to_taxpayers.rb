class AddSlugToTaxpayers < ActiveRecord::Migration[5.1]
  def change
    add_column :taxpayers, :slug, :string
    add_index :taxpayers, :slug, unique: true
  end
end
