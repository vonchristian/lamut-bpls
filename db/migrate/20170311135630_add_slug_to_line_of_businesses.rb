class AddSlugToLineOfBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :line_of_businesses, :slug, :string
    add_index :line_of_businesses, :slug, unique: true
  end
end
