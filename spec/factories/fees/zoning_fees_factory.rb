FactoryBot.define do
  factory :zoning_fee, class: "Fees::ZoningFee" do
    amount 100
    business nil
  end
end
