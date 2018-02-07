class AddGrossLimitToGrossSalesTaxes < ActiveRecord::Migration[5.1]
  def change
    add_column :gross_sales_taxes, :gross_limit, :decimal
  end
end
