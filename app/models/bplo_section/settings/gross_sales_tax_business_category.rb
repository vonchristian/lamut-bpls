module BploSection
  module Settings
    class GrossSalesTaxBusinessCategory < ApplicationRecord
      extend FriendlyId
      friendly_id :name, use: :slugged
      has_many :gross_sales_taxes, class_name: "Taxes::GrossSalesTax"
      has_many :line_of_businesses, class_name: "BploSection::Settings::LineOfBusiness"
      def retailer?
        ["Retailers", "retailers", "Retail", "retail", "Retailer", "retailer"].include?(name)
      end
    end
  end
end
