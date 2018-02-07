class AddSlugToGrossSalesTaxBusinessCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :gross_sales_tax_business_categories, :slug, :string
    add_index :gross_sales_tax_business_categories, :slug, unique: true
  end
end
