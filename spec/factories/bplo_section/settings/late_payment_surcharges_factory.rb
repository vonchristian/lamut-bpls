FactoryBot.define do
  factory :late_payment_surcharge, class: "BploSection::Settings::LatePaymentSurcharge" do
    rate "9.99"
  end
end
