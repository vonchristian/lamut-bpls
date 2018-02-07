module Businesses
  class BusinessFee < ApplicationRecord
    has_paper_trail
    belongs_to :business
    belongs_to :fee

    # validates :fee_id, uniqueness: { scope: :business_id }
    delegate :name, :amount, :default_fee?,  to: :fee, allow_nil: true
    delegate :assessed_for_current_year?, to: :business
  end
end
