class Stall < ApplicationRecord
  enum stall_type: [:regular, :transient]
  belongs_to :public_market
  belongs_to :business
  validates :public_market_id, uniqueness: { scope: :business_id }

  delegate :name, to: :public_market, prefix: true, allow_nil: true
end
