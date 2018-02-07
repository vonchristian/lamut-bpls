module Tricycles
  class ApplicableTricycleFeePolicy < ApplicationPolicy
    def new?
      user.bplo_officer?
    end
    def create?
      new?
    end
    def destroy?
      user.bplo_officer?
    end
  end
end
