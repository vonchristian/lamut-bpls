module Fees
  class OccupancyPermitFeePolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.engineering_officer?
    end
  end
end
