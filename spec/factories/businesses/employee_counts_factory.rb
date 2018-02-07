FactoryBot.define do
  factory :employee_count, class: "Businesses::EmployeeCount" do
    business nil
    number 1
    type ""
  end
end
