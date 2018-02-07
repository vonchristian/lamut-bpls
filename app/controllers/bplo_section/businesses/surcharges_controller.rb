module BploSection
  module Businesses
    class SurchargesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @surcharge = @business.surcharges.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @surcharge = @business.surcharges.build(surcharge_params)
        if @surcharge.save
          redirect_to @business, notice: "Surcharge saved successfully."
        else
          render :new
        end
      end

      private
      def surcharge_params
        params.require(:businesses_surcharge).permit(:calendar_year, :amount)
      end
    end
  end
end
