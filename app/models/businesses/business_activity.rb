module Businesses
  class BusinessActivity < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    belongs_to :business

    belongs_to :line_of_business, class_name: "BploSection::Settings::LineOfBusiness"
    belongs_to :storage_permit_fee, class_name: "Fees::StoragePermitFee"

    has_many :gross_sales, class_name: "Businesses::GrossSale"
    delegate :name, to: :line_of_business
    delegate :mayors_permit_fee_amount, to: :line_of_business
    delegate :amount, to: :storage_permit_fee, prefix: true, allow_nil: true
    before_commit :set_storage_permit_fee, :set_business_requirements
    def self.total_fees 
      all.sum(&:total_fees)
    end
    def self.with_storage_permit_fees
      all.select{|a| a.storage_permit_fee.present?}
    end
    def total_fees
      mayors_permit_fee_amount * number_of_unit
    end

    def set_storage_permit_fee
      if line_of_business.has_storage_permit_fee?
        Fees::StoragePermitFee.set(self)
      end
    end
    def set_business_requirements
      BploSection::Settings::RequiredDocument.set_additional_requirements(self.business)
    end
  end
end
