module Businesses
  class BusinessPermitApplicationPolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.bplo_officer? || user.mayors_office_staff?
    end
  end
end
