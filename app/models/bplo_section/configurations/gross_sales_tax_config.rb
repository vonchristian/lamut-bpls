module BploSection
  module Configurations
    class GrossSalesTaxConfig < ApplicationRecord
      enum tax_config: [:per_business, :per_business_activity]
      def self.set_default(business)
        tax_config = BploSection::Configurations::GrossSalesTaxConfig.find_or_create_by(tax_config: 0)
        business.gross_sales_tax_config_id = tax_config.id
      end
    end
  end
end
