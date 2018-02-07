FactoryBot.define do
  factory :business_permit_application, class: "Businesses::BusinessPermits::BusinessPermitApplication" do
    business nil
    application_number { Faker::Number.number(10)}
    application_date Date.today
    transaction_type 'renew'
  end
end
