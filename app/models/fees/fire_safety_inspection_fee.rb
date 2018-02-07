module Fees
  class FireSafetyInspectionFee < ApplicationRecord
    belongs_to :fire_dept_collection
    validates :amount, presence: true, numericality: true
    def self.for_current_year
      fire_inspection_fee = all.select{ |a| a.calendar_year.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }.last
      if fire_inspection_fee
        fire_inspection_fee.amount
      else
        0
      end
    end
  end
end
