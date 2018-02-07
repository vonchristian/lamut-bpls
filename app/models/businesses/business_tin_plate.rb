module Businesses
  class BusinessTinPlate < ApplicationRecord
    belongs_to :business
    belongs_to :business_permit_approval, class_name: "Businesses::BusinessPermitApproval"
  end
end
