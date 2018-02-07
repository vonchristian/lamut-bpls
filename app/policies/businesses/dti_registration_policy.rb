module Businesses
  class DtiRegistrationPolicy < ApplicationPolicy
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
