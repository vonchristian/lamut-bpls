module BploSection
  module Settings
    class PermitApplicationDateRange < ApplicationRecord
      validates :start_date, :end_date, presence: true
      def date_range
        start_date..end_date
      end
    end
  end
end
