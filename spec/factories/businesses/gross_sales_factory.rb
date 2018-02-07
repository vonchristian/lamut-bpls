FactoryBot.define do
  factory :gross_sale, class: "Businesses::GrossSale" do
    business
    business_activity nil
    calendar_year "2017-03-11"
    tax_amount "9.99"
    amount 10_000
  end
end
