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
        find_applicable(gross_sale)
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
      def find_applicable_tax(gross_sale, tax)
        if tax.tax_type_fixed_amount?
          gross_sale.tax_amount = tax.tax_amount
        elsif tax.tax_type_percentage?
          gross_sales_tax_for_tax_type_percentage(gross_sale, tax)
        elsif tax.tax_type_percentage_with_tax_on_excess?
          tax_for_excess(gross_sales, tax)
        end
      end

      private
      def self.find_applicable(gross_sale)
        tax = gross_sale.business.gross_sales_tax_business_category.gross_sales_taxes.
        select{ |a| a.amount_range.include?(gross_sale.amount) }.first
        gross_sale.tax_amount = tax.find_applicable_tax(gross_sale, tax)
      end


      def self.tax_for_excess(gross_sale, tax)
        tax.gross_limit * tax.tax_rate +
        ((gross_sale.amount - tax.gross_limit) * (tax.tax_rate_for_excess))
      end

      def gross_sales_tax_for_tax_type_percentage(gross_sale, gross_sales_tax)
        amount = gross_sale.amount * gross_sales_tax.tax_rate
        if amount < gross_sales_tax.minimum_tax_amount
          gross_sales_tax.minimum_tax_amount
        else
          amount
        end
      end
    end
  end
end
