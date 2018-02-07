FactoryBot.define do
  factory :barangay, class: "Addresses::Barangay" do
    municipality_or_city nil
    name "MyString"
  end
end
