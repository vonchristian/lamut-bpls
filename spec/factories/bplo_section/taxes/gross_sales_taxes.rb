FactoryBot.define do
  factory :gross_sales_tax, class: "BploSection::Taxes::GrossSalesTax" do
    minimum_gross_sale "9.99"
    maximum_gross_sale "9.99"
    tax_amount "9.99"
    tax_type
  end
end
