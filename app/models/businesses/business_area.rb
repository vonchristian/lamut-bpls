module Businesses
  class BusinessArea < ApplicationRecord
    belongs_to :business
    belongs_to :sanitary_inspection_fee, class_name: "Fees::SanitaryInspectionFee"

    validates :area, presence: true, numericality: true
    after_save :set_sanitary_inspection_fee
    def fee
      if sanitary_inspection_fee
        sanitary_inspection_fee.amount
      else
        Fees::SanitaryInspectionFee.order(created_at: :asc).first.try(:amount)
      end
    end
    
    private
    def set_sanitary_inspection_fee
      Fees::SanitaryInspectionFee.set(self)
    end

  end
end
