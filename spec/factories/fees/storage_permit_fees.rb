FactoryBot.define do
  factory :storage_permit_fee, class: "Fees::StoragePermitFee" do
    name "MyString"
    amount "9.99"
    minimum_value "9.99"
    maximum_value "9.99"
  end
end
