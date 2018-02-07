FactoryBot.define do
  factory :business_area, class: 'Businesses::BusinessArea' do
    business nil
    area "9.99"
    rented false
  end
end
