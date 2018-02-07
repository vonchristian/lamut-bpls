class AddGrossSalesTaxBusinessCategoryToLineOfBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_reference :line_of_businesses, :mayors_permit_fee_business_category, foreign_key: true, type: :uuid, index: {name: "index_on_permit_fee_business_category" }
    add_reference :businesses, :gross_sales_tax_business_category,  foreign_key: true, type: :uuid, index: { name: "index_on_gross_tax_business_category"}
  end
end
