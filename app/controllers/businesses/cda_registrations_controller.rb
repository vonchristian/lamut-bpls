module Businesses
  class CdaRegistrationsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @registration = @business.build_cda_registration
      authorize @registration
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @registration = @business.create_cda_registration(cda_registration_params)
      authorize @registration
      if @registration.save
        redirect_to @business, notice: "CDA Registration saved successfully."
      else
        render :new
      end
    end

    private
    def cda_registration_params
      params.require(:businesses_cda_registration).permit(:registration_number, :date_issued, :expiry_date)
    end
  end
end
