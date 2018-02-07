module Businesses
  class DtiRegistration < ApplicationRecord
    belongs_to :business
    validates :registration_number, presence: true, uniqueness: true
    validates :date_issued, :expiry_date, presence: true

    def expired?
      expiry_date < Time.zone.now
    end
  end
end
