module BploSection
  module Businesses
    class ZoningFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @zoning_fee = @business.zoning_fees.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @zoning_fee = @business.zoning_fees.create(zoning_fee_params)
        if @zoning_fee.save
          redirect_to business_url(@business), notice: "Zoning Fee assessment saved successfully."
        else
          render :new
        end
      end

      private
      def zoning_fee_params
        params.require(:fees_zoning_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
