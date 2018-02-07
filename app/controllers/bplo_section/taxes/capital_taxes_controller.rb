module BploSection
  module Taxes
    class CapitalTaxesController < ApplicationController
      def new
        @capital_tax = BploSection::Taxes::CapitalTax.new
        authorize @capital_tax
      end
      def create
        @capital_tax = BploSection::Taxes::CapitalTax.create(capital_tax_params)
        authorize @capital_tax
        if @capital_tax.save
          redirect_to bplo_section_settings_url, notice: 'Capital Tax Rate saved successfully.'
        else
          render :new
        end
      end

      private
      def capital_tax_params
        params.require(:bplo_section_taxes_capital_tax).permit(:rate)
      end
    end
  end
end
