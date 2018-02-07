module Businesses
  module BusinessPermits
    class BusinessPermitApproval < ApplicationRecord
      include PgSearch
      multisearchable :against => [:permit_number]
      has_one :business_tin_plate, class_name: "Businesses::BusinessTinPlate", dependent: :destroy
      belongs_to :approver, class_name: "User", foreign_key: 'approver_id'
      belongs_to :business_permit_application, class_name: "Businesses::BusinessPermits::BusinessPermitApplication"
      has_many :conditions, dependent: :destroy, class_name: "BusinessPermitCondition"
      has_many :permit_conditions, through: :conditions
      delegate :business, to: :business_permit_application, allow_nil: true
      delegate :name, :ownership_type_name, :full_address, :taxpayers_full_name, to: :business, prefix: true, allow_nil: true
      delegate :taxpayers_full_name, to: :business, prefix: true, allow_nil: true
      delegate :transaction_type, :expired?, to: :business_permit_application, allow_nil: true

      validates :permit_number, presence: true, uniqueness: true
      after_save :set_default_conditions
      after_commit :set_business_status, :set_business_tin_plate, if: :persisted?
      accepts_nested_attributes_for :business_tin_plate
      #for reporting purposes
      def self.date_approved(business)
      end
      def self.for_current_year
        all.select {|a| a.date_approved.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)}
      end
      def name
        business.name
      end

      private
      def set_business_status
        if self.business_permit_application.new_application?
          business.new_business!
        elsif self.business_permit_application.renew?
          business.renewed!
        end
      end
      def set_default_conditions
        PermitCondition.set_default(self)
      end
      def set_business_tin_plate
        self.business.business_tin_plate = self.business_tin_plate
      end
    end
  end
end
