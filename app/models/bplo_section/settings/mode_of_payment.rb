module BploSection
  module Settings
    class ModeOfPayment < ApplicationRecord
      has_many :businesses
      validates :mode, presence: true, uniqueness: true
      def name
        mode
      end
      def semi_annually?
        mode == "Semi Annually"
      end
      def quarterly?
        mode == 'Quarterly'
      end
      def annually?
        mode = 'Annually'
      end
    end
  end
end
