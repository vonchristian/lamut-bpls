FactoryBot.define do
  factory :line_of_business, class: "BploSection::Settings::LineOfBusiness" do
    name "MyString"
    factory :line_of_business_with_mayors_permit_fee do
      mayors_permit_fee
    end
  end
end
