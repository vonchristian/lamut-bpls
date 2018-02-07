module Businesses
  class SecRegistrationsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @registration = @business.build_sec_registration
      authorize @registration
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @registration = @business.create_sec_registration(sec_registration_params)
      authorize @registration
      if @registration.save
        redirect_to @business, notice: "SEC Registration saved successfully."
      else
        render :new
      end
    end

    private
    def sec_registration_params
      params.require(:businesses_sec_registration).permit(:registration_number, :date_issued, :expiry_date)
    end
  end
end
