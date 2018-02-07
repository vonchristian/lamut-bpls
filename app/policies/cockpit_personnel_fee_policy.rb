class CockpitPersonnelFeePolicy < ApplicationPolicy
  def new?
    user.system_administrator?
  end
  def create?
    user.system_administrator?
  end
  def edit?
    create?
  end
  def update?
    edit?
  end
end
