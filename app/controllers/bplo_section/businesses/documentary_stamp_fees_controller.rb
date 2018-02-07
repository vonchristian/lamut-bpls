module BploSection
  module Businesses
    class DocumentaryStampFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @documentary_stamp_fee = @business.documentary_stamp_fees.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @documentary_stamp_fee = @business.documentary_stamp_fees.create(documentary_stamp_fee_params)
        if @documentary_stamp_fee.save
          redirect_to business_url(@business), notice: "Documentary Stamp Fee assessment saved successfully."
        else
          render :new
        end
      end
      def edit 
        @documentary_stamp_fee = Fees::DocumentaryStampFee.find(params[:id])
      end

      private
      def documentary_stamp_fee_params
        params.require(:fees_documentary_stamp_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
