module BploSection
  module Settings
    class Signatory < ApplicationRecord
      validates :first_name, :middle_name, :last_name, :designation, presence: :true

      def full_name
        "#{first_name} #{middle_name.first.capitalize}. #{last_name}"
      end
    end
  end
end
