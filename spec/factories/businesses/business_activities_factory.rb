FactoryBot.define do
  factory :business_activity, class: "Businesses::BusinessActivity" do
    business
    line_of_business
  end
end
