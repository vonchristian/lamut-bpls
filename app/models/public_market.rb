class PublicMarket < ApplicationRecord
  has_many :stalls
  has_many :businesses, through: :stalls
end
