module Fees
  class FareAdjustmentFeePolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.bplo_officer?
    end
  end
end
