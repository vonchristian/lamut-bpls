module BploSection
  module Settings
    class LatePaymentSurcharge < ApplicationRecord
      validates :rate, presence: true, numericality: true
    end
  end
end
