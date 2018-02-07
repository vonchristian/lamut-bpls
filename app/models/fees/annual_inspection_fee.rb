module Fees
  class AnnualInspectionFee < ApplicationRecord
    belongs_to :business
    validates :amount, presence: true, numericality: true
    
    def self.for_current_year
      annual_inspection_fee = all.select{ |a| a.calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }
      if annual_inspection_fee
        annual_inspection_fee.pluck(:amount).sum
      else
        0
      end
    end

    def self.assessment_for(business)
      paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
      business.annual_inspection_fees.for_current_year - paid_amount
    end


    def debit_account
      Accounting::Asset.find_by(name: 'Accounts Receivable - Annual Inspection Fees')
    end

    def credit_account
      Accounting::Revenue.find_by(name: 'Annual Inspection Fees')
    end
  end
end
