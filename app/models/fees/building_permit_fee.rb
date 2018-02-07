module Fees
  class BuildingPermitFee < ApplicationRecord
    belongs_to :business
    validates :amount, presence: true, numericality: true
    def self.for_current_year
      building_permit_fee = all.select{ |a| a.calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }
      if building_permit_fee
        building_permit_fee.pluck(:amount).sum
      else
        0
      end
    end
    def self.assessment_for(business)
      paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
      business.building_permit_fees.for_current_year - paid_amount
    end

    def debit_account
      Accounting::Asset.find_by(code: 103010104, name: 'Accounts Receivable - Building Permit Fees', active: true)
    end

    def credit_account
      Accounting::Revenue.find_by(code: 402010106, name: 'Building Permit Fees', active: true)
    end
  end
end
