module Fees
  class PlumbingInstallationFeePolicy < ApplicationPolicy
    def new?
      create?
    end
    def create?
      user.engineering_officer?
    end
  end
end
