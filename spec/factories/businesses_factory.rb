FactoryBot.define do
  factory :business do
    name { Faker::Company.unique.name }
    ownership_type
    mode_of_payment
    gross_sales_tax_business_category
    business_area
  end
end
