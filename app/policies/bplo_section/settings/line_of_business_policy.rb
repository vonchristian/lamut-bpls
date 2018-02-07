module BploSection
  module Settings
    class LineOfBusinessPolicy < Struct.new(:user, :record)
      def new?
        create?
      end
      def create?
        user.system_administrator?
      end
      def edit?
        create?
      end
      def update?
        edit?
      end
    end
  end
end
