module BploSection
  module Businesses
    class BuildingPermitFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @building_permit_fee = @business.building_permit_fees.build
        authorize @building_permit_fee
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @building_permit_fee = @business.building_permit_fees.create(building_permit_fee_params)
        authorize @building_permit_fee
        if @building_permit_fee.save
          redirect_to business_url(@business), notice: "Building Permit Fee assessment saved successfully."
        else
          render :new
        end
      end

      private
      def building_permit_fee_params
        params.require(:fees_building_permit_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
