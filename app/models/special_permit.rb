class SpecialPermit < ApplicationRecord
  enum special_permit_type: [:per_day, :flat_rate]
end
