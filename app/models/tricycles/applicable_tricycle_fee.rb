module Tricycles
  class ApplicableTricycleFee < ApplicationRecord
    belongs_to :tricycle_fee
    belongs_to :tricycle
    delegate :name, :amount, :default_fee?, to: :tricycle_fee, allow_nil: true

    def self.set_default_fees(tricycle)
      TricycleFee.default.each do |tricycle_fee|
        tricycle.applicable_tricycle_fees.find_or_create_by(tricycle_fee: tricycle_fee)
      end
    end

    def self.set_additional_fees(tricycle)
      if tricycle.new_transaction?
        set_fees_for_new_applicants(tricycle)
      elsif tricycle.renew_transaction?
        set_fees_for_renew_applicants(tricycle)
      end
    end
    def self.set_fees_for_new_applicants(tricycle)
      TricycleFee.for_new_applicants.each do |fee|
        tricycle.applicable_tricycle_fees.find_or_create_by(tricycle_fee: fee)
      end
    end
    def self.set_fees_for_renew_applicants(tricycle)
      TricycleFee.for_renew_applicants.each do |fee|
        tricycle.applicable_tricycle_fees.find_or_create_by(tricycle_fee: fee)
      end
    end
  end
end
