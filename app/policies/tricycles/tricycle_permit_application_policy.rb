module Tricycles
  class TricyclePermitApplicationPolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.bplo_officer?
    end
  end
end
