class StoragePermitFeePolicy < ApplicationPolicy
  def new?
    user.system_administrator?
  end
  def create?
    user.system_administrator?
  end
end
