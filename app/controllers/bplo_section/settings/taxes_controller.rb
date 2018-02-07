module BploSection
  module Settings
    class TaxesController < ApplicationController
      def edit
        @tax = BploSection::Taxes::GrossSalesTax.find(params[:id])
      end
      def update
        @tax = BploSection::Taxes::GrossSalesTax.find(params[:id])
        @tax.update(tax_params)
        if @tax.valid?
          @tax.save
          redirect_to bplo_section_settings_url, notice: "Tax updated successfully"
        else
          render :edit
        end
      end

      private
      def tax_params
        params.require(:bplo_section_taxes_gross_sales_tax).permit(:minimum_gross_sale, :maximum_gross_sale, :tax_rate, :tax_rate_for_excess, :tax_amount, :minimum_tax_amount)
      end
    end
  end
end
