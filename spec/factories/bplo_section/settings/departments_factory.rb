FactoryBot.define do
  factory :department, class: "BploSection::Settings::Department" do
    name { Faker::Company.name }
  end
end
