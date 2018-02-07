module Registrations
  class CdaRegistrationsController < ApplicationController
    def edit
      @registration = Businesses::CdaRegistration.find(params[:id])
      authorize @registration
    end
    def update
      @registration = Businesses::CdaRegistration.find(params[:id])
      authorize @registration
      @registration.update(cda_registration_params)
      if @registration.save
        redirect_to business_url(@registration.business), notice: "Registration updated successfully."
      else
        render :edit
      end
    end

    private
    def cda_registration_params
      params.require(:businesses_cda_registration).permit(:registration_number, :date_issued, :expiry_date)
    end
  end
end
