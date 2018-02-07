module BploSection
  module Businesses
    class AnnualInspectionFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @annual_inspection_fee = @business.annual_inspection_fees.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @annual_inspection_fee = @business.annual_inspection_fees.create(annual_inspection_fee_params)
        if @annual_inspection_fee.save
          redirect_to business_url(@business), notice: "Annual Inspection Fee assessment saved successfully."
        else
          render :new
        end
      end

      private
      def annual_inspection_fee_params
        params.require(:fees_annual_inspection_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
