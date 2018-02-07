FactoryBot.define do
  factory :mode_of_payment, class: "BploSection::Settings::ModeOfPayment" do
    mode { Faker::Company.name }
  end
end
