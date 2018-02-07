class AddMinimumTaxAmountToGrossSalesTaxes < ActiveRecord::Migration[5.1]
  def change
    add_column :gross_sales_taxes, :minimum_tax_amount, :decimal
  end
end
