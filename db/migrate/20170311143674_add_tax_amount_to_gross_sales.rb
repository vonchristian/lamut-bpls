class AddTaxAmountToGrossSales < ActiveRecord::Migration[5.1]
  def change
    add_column :gross_sales, :tax_amount, :decimal
  end
end
