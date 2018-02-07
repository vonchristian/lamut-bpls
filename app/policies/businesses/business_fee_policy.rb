module Businesses
  class BusinessFeePolicy < ApplicationPolicy
    def new?
      create?
    end

    def create?
      user.bplo_officer?
    end
    def destroy?
      create?
    end
  end
end
