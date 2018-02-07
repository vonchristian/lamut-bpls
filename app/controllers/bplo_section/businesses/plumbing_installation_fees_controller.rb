module BploSection
  module Businesses
    class PlumbingInstallationFeesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @plumbing_installation_fee = @business.plumbing_installation_fees.build
        authorize @plumbing_installation_fee
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @plumbing_installation_fee = @business.plumbing_installation_fees.create(plumbing_installation_fee_params)
        authorize @plumbing_installation_fee
        if @plumbing_installation_fee.save
          redirect_to business_url(@business), notice: "Plumbing Installation Fee assessment saved successfully."
        else
          render :new
        end
      end

      private
      def plumbing_installation_fee_params
        params.require(:fees_plumbing_installation_fee).permit(:amount, :calendar_year)
      end
    end
  end
end
