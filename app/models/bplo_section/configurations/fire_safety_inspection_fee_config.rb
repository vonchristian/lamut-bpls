module BploSection
  module Configurations
    class FireSafetyInspectionFeeConfig < ApplicationRecord
      enum fee_type: [:fixed_amount, :percent]


      def self.percentage(business)
        business.total_fees_and_taxes * default_percent
      end
      def self.default_percent
        if self.last
          self.last.percent
        else
          10
        end
      end
    end
  end
end
