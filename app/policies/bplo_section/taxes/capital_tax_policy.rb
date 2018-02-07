module BploSection
  module Taxes
    class CapitalTaxPolicy < ApplicationPolicy
      def new?
        create?
      end
      def create?
        user.bplo_officer? || user.system_administrator?
      end
    end
  end
end
