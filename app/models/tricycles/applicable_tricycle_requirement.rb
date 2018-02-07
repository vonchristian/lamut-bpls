module Tricycles
  class ApplicableTricycleRequirement < ApplicationRecord
    belongs_to :tricycle_requirement
    belongs_to :tricycle
    has_many :verifications, class_name: "Tricycles::TricycleRequirementVerification"
    delegate :name, :department_name, to: :tricycle_requirement, allow_nil: true
    def self.set_default_requirements(tricycle)
      TricycleRequirement.default.each do |required_document|
        tricycle.applicable_tricycle_requirements.find_or_create_by(tricycle_requirement: required_document)
      end
    end
    def self.verified
      all.select{ |a| a.verified? }
    end
    def department
      tricycle_requirement.department
    end
    def verified?
      has_current_verification?
    end

    def has_current_verification?
      verifications.present? && verifications.order(created_at: :asc).last.submission_date && verifications.order(created_at: :asc).last.submission_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    end
  end
end
