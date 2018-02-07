module Businesses
  module BusinessPermits
    class Revocation < ApplicationRecord
      belongs_to :business
      validates :remarks, :date, presence: true
      after_commit :set_business_status

      private
      def set_business_status
        business.closed!
      end
    end
  end
end
