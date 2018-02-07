class PaymentPolicy < ApplicationPolicy
  def new?
    create?
  end
  def create?
    user.collection_officer?
  end
end
