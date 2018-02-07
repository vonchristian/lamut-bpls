module BploSection
  module Configurations
    class GrossSalesTaxConfigsController < ApplicationController
      def edit
        @business = Business.friendly.find(params[:business_id])
        @gross_sales_tax_config = @business.build_gross_sales_tax_config
      end
      def update
        @business = Business.friendly_id.find(params[:business_id])
        @gross_sales_tax_config = @business.build_gross_sales_tax_config(gross_sales_tax_config_params)
        if @gross_sales_tax_config.save
          redirect_to business_url(@business), notice: "Gross sales tax configuration updated successfully."
        else
          render :edit
        end
      end
      private
      def gross_sales_tax_config_params
        params.require(:business).permit(:gross_sales_tax_config_id)
      end
    end
  end
end
