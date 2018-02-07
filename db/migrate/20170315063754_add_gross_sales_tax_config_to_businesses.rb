class AddGrossSalesTaxConfigToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :businesses, :gross_sales_tax_config, foreign_key: true, type: :uuid
  end
end
