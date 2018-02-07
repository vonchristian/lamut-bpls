class BusinessPermitCondition < ApplicationRecord
  belongs_to :permit_condition
  belongs_to :business_permit_approval
end
