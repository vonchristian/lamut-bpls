module BploSection
  module Businesses
    class ElectricalInstallationFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @electrical_installation_fee = @business.electrical_installation_fees.build
        authorize @electrical_installation_fee
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @electrical_installation_fee = @business.electrical_installation_fees.create(electrical_installation_fee_params)
        authorize @electrical_installation_fee
        if @electrical_installation_fee.save
          redirect_to business_url(@business), notice: "Electrical Installation Fee assessment saved successfully."
        else
          render :new
        end
      end

      private
      def electrical_installation_fee_params
        params.require(:fees_electrical_installation_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
