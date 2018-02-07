module Fees
  class SanitaryInspectionFee < ApplicationRecord
    has_many :business_areas, class_name: "Businesses::BusinessArea"

    def self.set(business_area)
      sanitary_inspection_fee = all.select { |a| a.area_range.include?(business_area.area) }.first
      if sanitary_inspection_fee
        business_area.sanitary_inspection_fee = sanitary_inspection_fee
      else
        business_area.sanitary_inspection_fee = Fees::SanitaryInspectionFee.order(created_at: :asc).first
      end
    end
    def area_range
      minimum_area..maximum_area
    end
    def self.assessment_for(business)
      paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
      business.business_area_fee - paid_amount
    end

    def debit_account
      Accounting::Asset.find_by(code: 1030101010, name: 'Accounts Receivable - Sanitary Inspection Fees')
    end
    def credit_account
      Accounting::Revenue.find_by(code: 402011002, name: "Sanitary Inspection Fees")
    end
  end
end
