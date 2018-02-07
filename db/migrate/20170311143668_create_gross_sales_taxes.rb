class CreateGrossSalesTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :gross_sales_taxes, id: :uuid do |t|
      t.decimal :minimum_gross_sale
      t.decimal :maximum_gross_sale
      t.decimal :tax_amount

      t.timestamps
    end
  end
end
