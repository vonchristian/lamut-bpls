module Fees
  class ZoningFee < ApplicationRecord
    belongs_to :business

    validates :amount, presence: true, numericality: { greater_than: 0.1 }

    def self.for_current_year
      zoning_fee = all.select{ |a| a.calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }
      if zoning_fee
        zoning_fee.pluck(:amount).sum
      else
        0
      end
    end
    def self.assessment_for(business)
      paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
      business.zoning_fees.for_current_year - paid_amount
    end

    def debit_account
      Accounting::Asset.find_by(code: 103010105, name: 'Accounts Receivable - Zonal/Location Permit Fees')
    end

    def credit_account
      Accounting::Revenue.find_by(code: 402010107, name: "Zonal/Location Permit Fees")
    end
  end
end
