module Tricycles
  class TricycleRequirementPolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.system_administrator?
    end
    def destroy?
      create?
    end
    def edit?
      create?
    end
    def update?
      edit?
    end
  end
end
