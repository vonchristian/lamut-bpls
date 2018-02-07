FactoryBot.define do
  factory :required_document, class: "BploSection::Settings::RequiredDocument" do
    department nil
    name { Faker::Company.unique.catch_phrase }
  end
end
