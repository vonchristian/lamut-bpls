module Businesses
  class Surcharge < ApplicationRecord
    belongs_to :surchargeable, polymorphic: true
    def self.set_surcharge(surchargeable)
      if surchargeable.late_registration?
        rate = BploSection::Settings::LatePaymentSurcharge.order(created_at: :desc).last.rate
        surchargeable.total_mayors_permit_fees * rate
      end
    end

    def self.for_current_year
      surcharge = all.select{ |a| a.calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }.last
      if surcharge
        surcharge.amount
      else
        0
      end
    end

    def self.assessment_for(business)
      paid_amount = self.new.debit_account.credit_entries.payment.where(commercial_document: business).collect{|a| a.credit_amounts.where(account: self.new.debit_account).pluck(:amount).sum}.sum
      business.surcharges.for_current_year - paid_amount
    end

    def self.current_year
      all.find{ |a| a.current? }
    end
    def current?
      calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    end



    def debit_account
      Accounting::Asset.find_by(name: 'Accounts Receivable - Surcharges', active: true)
    end

    def credit_account
      Accounting::Revenue.find_by(name: 'Surcharges', active: true)
    end
  end
end
