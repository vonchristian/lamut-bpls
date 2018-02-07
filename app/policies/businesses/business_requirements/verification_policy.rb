module Businesses
  module BusinessRequirements
    class VerificationPolicy < ApplicationPolicy
      def new?
        create?
      end

      def create?
        user.bplo_officer?
      end
    end
  end
end
