FactoryBot.define do
  factory :mayors_permit_fee_business_category, class: "BploSection::Settings::MayorsPermitFeeBusinessCategory" do
    name { Faker::Company.name }
  end
end
