module Businesses
  class SurchargePolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.bplo_officer?
    end
  end
end
