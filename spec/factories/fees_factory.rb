FactoryBot.define do
  factory :fee do
    name { Faker::Company.name }
    amount "9.99"
    default_fee false
  end
end
