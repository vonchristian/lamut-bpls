FactoryBot.define do
  factory :sanitary_inspection_fee, class: "Fees::SanitaryInspectionFee" do
    minimum_area 1
    maximum_area 10
    amount "9.99"
  end
end
