FactoryBot.define do
  factory :ownership_type, class: "BploSection::Settings::OwnershipType" do
    name { Faker::Company.name }
  end
end
