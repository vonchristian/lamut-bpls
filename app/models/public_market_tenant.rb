class PublicMarketTenant < ApplicationRecord
  enum vendor_type: [:regular, :transient]

  has_many :businesses
end
