module Businesses
  module BusinessRequirements
    class VerificationPolicy < ApplicationPolicy
      def new?
        create?
      end

      def create?
        user.bplo_officer? || user.mayors_office_staff?
      end
    end
  end
end
