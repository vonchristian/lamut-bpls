module BploSection
  module Settings
    class TaxType < ApplicationRecord
      enum tax_type: [:fixed_amount, :percentage, :percentage_with_tax_on_excess]
      has_many :gross_sales_taxes, class_name: "BploSection::Taxes::GrossSalesTax"
    end
  end
end
