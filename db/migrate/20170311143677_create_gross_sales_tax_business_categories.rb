class CreateGrossSalesTaxBusinessCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :gross_sales_tax_business_categories, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :gross_sales_tax_business_categories, :name, unique: true
  end
end
