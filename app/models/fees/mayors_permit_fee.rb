module Fees
  class MayorsPermitFee < ApplicationRecord
    belongs_to :line_of_business, class_name: "BploSection::Settings::LineOfBusiness"

    def self.total
      all.sum(&:total_fee)
    end

    def self.assessment_for(business)
      paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
      business.business_activities.total_fees - paid_amount
    end
    def self.paid_amount(business)
      self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
    end

    def total_fee
      amount
    end
    def number_of_unit
      Businesses::BusinessActivity.where(line_of_business_id: self.line_of_business.id)
    end
    def debit_account
      Accounting::Asset.find_by(name: 'Accounts Receivable - Business Permit Fees')
    end

    def credit_account
      Accounting::Revenue.find_by(name: 'Business Permit Fees')
    end
  end
end
