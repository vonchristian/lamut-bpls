FactoryBot.define do
  factory :fire_safety_inspection_fee_config, class: "BploSection::Configurations::FireSafetyInspectionFeeConfig" do
    amount 100
    percent 10
    fee_type 1
  end
end
