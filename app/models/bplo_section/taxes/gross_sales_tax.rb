module BploSection
  module Taxes
    class GrossSalesTax < ApplicationRecord
      RETAILER_GROSS_MAX = 400_000
      belongs_to :tax_type, class_name: "BploSection::Settings::TaxType"
      belongs_to :gross_sales_tax_business_category, class_name: "BploSection::Settings::GrossSalesTaxBusinessCategory"
      delegate :fixed_amount?, :percentage?, :percentage_with_tax_on_excess?, to: :tax_type, prefix: true, allow_nil: true
      delegate :name, to: :gross_sales_tax_business_category, prefix: true
      with_options :if => :fixed_amount? do |tax|
        tax. validates :minimum_gross_sale, presence: true, numericality: true
        tax. validates :maximum_gross_sale, presence: true, numericality: true
      end
      def self.set_tax(gross_sale)
        gross_sales_tax = gross_sale.gross_sales_tax_business_category.gross_sales_taxes.select{|a| a.amount_range.include?(gross_sale.amount)}.first
        return gross_sale.tax_amount = gross_sales_tax.tax_amount if gross_sales_tax.tax_type_fixed_amount?
        return gross_sales_tax_for_tax_type_percentage if gross_sales_tax.tax_type_percentage?
        return gross_sale.tax_amount = gross_sales_tax.gross_limit * gross_sales_tax.tax_rate + ((gross_sale.amount - gross_sales_tax.gross_limit) * (gross_sales_tax.tax_rate_for_excess)) if gross_sales_tax.tax_type_percentage_with_tax_on_excess?
        gross_sale.save
      end
      def amount_range
        minimum_gross_sale..maximum_gross_sale
      end
      def rate
        if tax_type_fixed_amount?
          tax_amount
        elsif tax_type_percentage?
          tax_rate
        elsif tax_type_percentage_with_tax_on_excess?
          tax_rate
        end
      end

      def fixed_amount?
        tax_type == 'fixed_amount'
      end
      private
      def gross_sales_tax_for_tax_type_percentage
        amount = gross_sale.tax_amount = gross_sale.amount * gross_sales_tax.tax_rate
        if amount > minimmum_tax_amount
          amount
        else
          minimmum_tax_amount
        end
      end
    end
  end
end
