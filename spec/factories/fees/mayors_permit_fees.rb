FactoryBot.define do
  factory :mayors_permit_fee, class: "Fees::MayorsPermitFee" do
    line_of_business nil
    amount "9.99"
  end
end
