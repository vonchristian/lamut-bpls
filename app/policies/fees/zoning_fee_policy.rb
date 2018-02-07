module Fees
  class ZoningFeePolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.zoning_officer?
    end
  end
end
