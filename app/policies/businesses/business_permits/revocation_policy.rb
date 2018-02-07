module Businesses
  module BusinessPermits
    class RevocationPolicy < ApplicationPolicy
      def new?
        create?
      end
      def create?
        user.bplo_officer?
      end
    end
  end
end
