module BploSection
  module Businesses
    class OccupancyPermitFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @occupancy_permit_fee = @business.occupancy_permit_fees.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @occupancy_permit_fee = @business.occupancy_permit_fees.create(occupancy_permit_fee_params)
        if @occupancy_permit_fee.save
          redirect_to business_url(@business), notice: "Occupancy Permit Fee assessment saved successfully."
        else
          render :new
        end
      end

      private
      def occupancy_permit_fee_params
        params.require(:fees_occupancy_permit_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
