FactoryBot.define do
  factory :business_capital, class: "Businesses::BusinessCapital" do
    amount "9.99"
    business nil
  end
end
