module Businesses
  class FireSafetyInspectionFeeCollectionPolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.fire_safety_officer?
    end
  end
end
