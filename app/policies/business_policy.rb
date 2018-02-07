class BusinessPolicy < Struct.new(:user, :business)
  def new?
    create?
  end
  def create?
    user.bplo_officer? || user.application_officer?
  end
  def edit?
    user.bplo_officer?
  end
  def update?
    edit?
  end
  def destroy?
    user.system_administrator?
  end
end
