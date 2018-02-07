module BploSection
  module Taxes
    class CapitalTax < ApplicationRecord
      validates :rate, presence: true, numericality: true

      def self.set_tax(capital)
        capital.tax = capital.amount * rate
      end
      def self.rate
        all.last.rate
      end
    end
  end
end
