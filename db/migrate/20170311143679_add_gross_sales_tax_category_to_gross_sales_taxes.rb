class AddGrossSalesTaxCategoryToGrossSalesTaxes < ActiveRecord::Migration[5.1]
  def change
    add_reference :gross_sales_taxes, :gross_sales_tax_business_category, foreign_key: true, type: :uuid
  end
end
