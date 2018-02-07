class TaxpayerPolicy < ApplicationPolicy
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
  def destroy?
    record.can_be_destroyed?
  end
end
