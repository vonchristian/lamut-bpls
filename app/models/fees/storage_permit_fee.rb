module Fees
  class StoragePermitFee < ApplicationRecord

    def self.total
      all.sum(&:amount)
    end
    def self.set(business_activity)
      storage_permit_fee = all.select { |a| a.volume_range.include?(business_activity.volume) }.first
      if storage_permit_fee
        business_activity.storage_permit_fee = storage_permit_fee
      end
    end

    def self.assessment_for(business)
      paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
      business.total_storage_permit_fees - paid_amount
    end
    
    def volume_range
      minimum_value..maximum_value
    end
    def debit_account
      Accounting::Asset.find_by(code: 1030101011, name: 'Accounts Receivable - Storage Permit Fees')
    end
    def credit_account
      Accounting::Revenue.find_by(code: 402011004, name: "Storage Permit Fees")
    end
  end
end
