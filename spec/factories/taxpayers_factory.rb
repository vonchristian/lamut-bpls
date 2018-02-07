FactoryBot.define do
  factory :taxpayer do
    first_name     { Faker::Name.first_name }
    middle_name    { Faker::Name.last_name }
    last_name      { Faker::Name.last_name }
    sex 'male'
    contact_number { Faker::Number.number(11)}
  end
end
