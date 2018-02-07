module Businesses
  module BusinessRequirements
    class IssuancePolicy < Struct.new(:user, :issuance)
      def new?
        create?
      end
      def create?
        user.can_issue?(issuance)
      end
    end
  end
end
