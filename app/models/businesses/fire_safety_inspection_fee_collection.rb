module Businesses
  class FireSafetyInspectionFeeCollection < ApplicationRecord
    belongs_to :business

    def self.for_current_year
      fire_safety_inspection_fee = all.select{ |a| a.date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }.last
      if fire_safety_inspection_fee
        fire_safety_inspection_fee.amount
      else
        0
      end
    end
  end
end
