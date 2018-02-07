module Businesses
  class SecRegistrationPolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.bplo_officer?
    end
    def edit?
      create?
    end
    def update?
      edit?
    end
  end
end
