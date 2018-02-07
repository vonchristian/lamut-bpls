module Tricycles
  class AssessmentPolicy < ApplicationPolicy
    def new?
      user.bplo_officer?
    end
    def create?
      user.bplo_officer?
    end
  end
end 
