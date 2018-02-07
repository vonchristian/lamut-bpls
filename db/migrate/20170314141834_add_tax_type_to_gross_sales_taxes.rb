class AddTaxTypeToGrossSalesTaxes < ActiveRecord::Migration[5.1]
  def change
    add_reference :gross_sales_taxes, :tax_type, foreign_key: true, type: :uuid
  end
end
