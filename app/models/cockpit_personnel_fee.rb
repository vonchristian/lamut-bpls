class CockpitPersonnelFee < ApplicationRecord
  def self.assessment_for(business)
    paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
    CockpitDetail.set_cockpit_operation_fees(business) - paid_amount
  end

  def debit_account
    Accounting::Asset.find_by(name: 'Accounts Receivable - Cockpit Operation Fees')
  end

  def credit_account
    Accounting::Revenue.find_by(name: 'Cockpit Operation Fees')
  end
end
