module BploSection
  module Settings
    class RequiredDocument < ApplicationRecord
      extend FriendlyId
      friendly_id :name, use: :slugged
      belongs_to :department, class_name: "BploSection::Settings::Department"

      validates :name, presence:true, uniqueness: true

      delegate :name, to: :department, prefix: true, allow_nil: true
      has_many :business_requirements, class_name: "Businesses::BusinessRequirement", dependent: :destroy
      def self.set_default_requirements(business)
        default.each do |required_document|
          business.business_requirements.find_or_create_by!(required_document: required_document)
        end
      end
      def self.set_additional_requirements(business)
        business.additional_business_requirements.each do |required_document|
          business.business_requirements.find_or_create_by!(required_document: required_document)
        end
      end
      def self.available_additional_requirements(business)
        all - business.required_documents.uniq
      end

      def self.not_default
        all.where(default_requirement: false)
      end
      def self.default
        all.where(default_requirement: true)
      end
    end
  end
end
