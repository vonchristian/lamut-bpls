module Businesses
  class BusinessRequirement < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    belongs_to :required_document, class_name: "BploSection::Settings::RequiredDocument"
    belongs_to :business
    has_many :verifications, class_name: "Businesses::BusinessRequirements::Verification", dependent: :destroy
    has_many :issuances, class_name: "Businesses::BusinessRequirements::Issuance", dependent: :destroy

    delegate :name, :default_requirement?, to: :required_document, allow_nil: true
    delegate :department_name, to: :required_document
    def self.verified
      all.select{ |a| a.verified? }
    end
    def self.not_verified
      all.select{ |a| !a.verified? }
    end
    def department
      required_document.department
    end
    def verified?
      has_current_verification? || has_current_issuance?
    end

    def has_current_verification?
      verifications.present? && verifications.last.submission_date && verifications.last.submission_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    end
    def has_current_issuance?
      issuances.present?  && issuances.last.issue_date && issuances.last.issue_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    end
  end
end
