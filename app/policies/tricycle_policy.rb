class TricyclePolicy < ApplicationPolicy
  def new?
    user.bplo_officer?
  end
  def create?
    new?
  end
  def edit?
  	new?
  end
  def update?
  	new?
  end
  def destroy?
    user.system_administrator? || user.bplo_officer?
  end
end
