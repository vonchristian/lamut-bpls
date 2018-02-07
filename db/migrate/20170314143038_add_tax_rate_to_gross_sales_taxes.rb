class AddTaxRateToGrossSalesTaxes < ActiveRecord::Migration[5.1]
  def change
    add_column :gross_sales_taxes, :tax_rate, :decimal
    add_column :gross_sales_taxes, :tax_rate_for_excess, :decimal
  end
end
