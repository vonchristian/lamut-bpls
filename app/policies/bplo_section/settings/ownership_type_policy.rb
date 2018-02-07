module BploSection
  module Settings
    class OwnershipTypePolicy < Struct.new(:user, :record)
      def new?
        create?
      end
      def create?
        user.system_administrator?
      end
    end
  end
end
