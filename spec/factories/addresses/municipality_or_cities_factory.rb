FactoryBot.define do
  factory :municipality_or_city, class: "Addresses::MunicipalityOrCity" do
    province nil
    name "MyString"
  end
end
