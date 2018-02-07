module Businesses
  class BusinessActivityPolicy < ApplicationPolicy
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
