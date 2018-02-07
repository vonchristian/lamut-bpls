module Businesses
  class DtiRegistrationsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @registration = @business.build_dti_registration
      authorize @registration
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @registration = @business.create_dti_registration(dti_registration_params)
      authorize @registration
      if @registration.save
        redirect_to @business, notice: "DTI Registration saved successfully."
      else
        render :new
      end
    end

    private
    def dti_registration_params
      params.require(:businesses_dti_registration).permit(:registration_number, :date_issued, :expiry_date)
    end
  end
end
