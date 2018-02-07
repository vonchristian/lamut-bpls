module BploSection
  module Businesses
    class GrossSalesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @gross_sale = @business.gross_sales.build
        authorize @gross_sale
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @gross_sale = @business.gross_sales.create(gross_sale_params)
        authorize @gross_sale
        if @gross_sale.save
          redirect_to business_url(@business), notice: "Gross Sale saved successfully."
        else
          render :new
        end
      end
      def edit
        @business = Business.friendly.find(params[:business_id])
        @gross_sale = Businesses::GrossSale.find(params[:id])
      end
      def update
        @gross_sale = Businesses::GrossSale.find(params[:id])
        @gross_sale.update(gross_sale_params)
        if @gross_sale.valid?
          @gross_sale.save
          redirect_to business_url(@gross_sale.business), notice: "Gross Sale updated successfully."
        else
          render :edit
        end
      end

      private
      def gross_sale_params
        params.require(:businesses_gross_sale).permit(:amount, :calendar_year)
      end
    end
  end
end
