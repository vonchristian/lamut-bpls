module BploSection
  module Businesses
    class StallsController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @stall = @business.stalls.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @stall = @business.stalls.create(stall_params)
        if @stall.valid?
          @stall.save
          redirect_to business_settings_url(@business), notice: "added successfully"
        else
          render :new
        end
      end

      private
      def stall_params
        params.require(:stall).permit(:public_market_id, :stall_type)
      end
    end
  end
end
