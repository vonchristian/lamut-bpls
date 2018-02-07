FactoryBot.define do
  factory :signatory, class: "BploSection::Settings::Signatory" do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    middle_name  { Faker::Name.last_name }
    designation "Mayor"
  end
end
