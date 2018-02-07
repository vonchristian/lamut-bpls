module BploSection
  module Businesses
    class OtherAccessoriesFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @other_accessories_fee = @business.other_accessories_fees.build
        authorize @other_accessories_fee
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @other_accessories_fee = @business.other_accessories_fees.create(other_accessories_fee_params)
        authorize @other_accessories_fee
        if @other_accessories_fee.save
          redirect_to business_url(@business), notice: "Other Accessories Fee assessment saved successfully."
        else
          render :new
        end
      end

      private
      def other_accessories_fee_params
        params.require(:fees_other_accessories_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
