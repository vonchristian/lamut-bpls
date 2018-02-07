module Businesses
  module BusinessPermits
    class BusinessPermitApplication < ApplicationRecord
      enum transaction_type: [:new_application, :renew]
      belongs_to :business
      has_one :business_permit_approval, class_name: "Businesses::BusinessPermits::BusinessPermitApproval", dependent: :destroy

      validates :application_number, presence: true, uniqueness: true
      validates :application_date, presence: true


      def self.for_current_year
        all.select {|a| a.application_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)}
      end

      def approved?
        business_permit_approval.present?
      end
      def expired?
        business_permit_approval.date_approved > Time.zone.now.tomorrow
      end
    end
  end
end
