module Fees
  class FareAdjustmentFee < ApplicationRecord
    belongs_to :tricycle
    validates :amount, presence: true, numericality: true
    

    def self.for_current_year
      fare_adjustment_fee = all.select{ |a| a.calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }.last
      if fare_adjustment_fee
        fare_adjustment_fee.amount
      else
        0
      end
    end

    def debit_account
      Accounting::Asset.find_by(name: 'Accounts Receivable - Fare Adjustment Fees')
    end

    def credit_account
      Accounting::Revenue.find_by(name: 'Fare Adjustment Fees')
    end
  end
end
