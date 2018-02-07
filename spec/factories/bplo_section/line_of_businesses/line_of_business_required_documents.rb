FactoryBot.define do
  factory :line_of_business_required_document, class: "BploSection::LineOfBusinesses::LineOfBusinessRequiredDocument" do
    line_of_business nil
    required_document nil
  end
end
