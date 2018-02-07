module Businesses
  module BusinessRequirements
    class Verification < ApplicationRecord
      belongs_to :business_requirement, class_name: "Businesses::BusinessRequirement"

      before_commit :set_submission_date
  
      def self.for_current_year
        verification = all.select{ |a| a.submission_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }.last
      end

      private
      def set_submission_date
        self.submission_date ||= Time.zone.now
      end
    end
  end
end
