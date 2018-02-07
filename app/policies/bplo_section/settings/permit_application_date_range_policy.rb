module BploSection
  module Settings
    class PermitApplicationDateRangePolicy < Struct.new(:user, :record)
      def new?
        create?
      end
      def create?
        user.system_administrator?
      end
    end
  end
end
