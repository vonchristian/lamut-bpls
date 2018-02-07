module Businesses
  module BusinessRequirements
    class Issuance < ApplicationRecord
      belongs_to :business_requirement, class_name: "Businesses::BusinessRequirement"
      validates :reference_number, :issue_date, presence: true
      delegate :department, to: :business_requirement
    end
  end
end
