module BploSection
  module Taxes
    class GrossSalesTaxesController < ApplicationController
      def new
        @business_category = BploSection::Settings::GrossSalesTaxBusinessCategory.friendly.find(params[:gross_sales_tax_business_category_id])
        @gross_sales_tax = @business_category.gross_sales_taxes.build
      end
      def create
        @business_category = BploSection::Settings::GrossSalesTaxBusinessCategory.friendly.find(params[:gross_sales_tax_business_category_id])
        @gross_sales_tax = @business_category.gross_sales_taxes.create(gross_sales_tax_params)
        if @gross_sales_tax.save
          redirect_to bplo_section_gross_sales_tax_business_category_url(@business_category), notice: 'Gross Sales Tax created successfully.'
        else
          render :new
        end
      end
      private
      def gross_sales_tax_params
        params.require(:bplo_section_taxes_gross_sales_tax).permit(:minimum_gross_sale, :maximum_gross_sale, :tax_amount)
      end
    end
  end
end
