module BploSection
  module Businesses
    class SealingFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @sealing_fee = @business.sealing_fees.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @sealing_fee = @business.sealing_fees.create(sealing_fee_params)
        if @sealing_fee.save
          redirect_to business_url(@business), notice: "Sealing Fee assessment saved successfully."
        else
          render :new
        end
      end

      private
      def sealing_fee_params
        params.require(:fees_sealing_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
