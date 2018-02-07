FactoryBot.define do
  factory :business_requirement, class: 'Businesses::BusinessRequirement' do
    required_document nil
    business nil
  end
end
