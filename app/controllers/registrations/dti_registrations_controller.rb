module Registrations
  class DtiRegistrationsController < ApplicationController
    def edit
      @registration = Businesses::DtiRegistration.find(params[:id])
      authorize @registration
    end
    def update
      @registration = Businesses::DtiRegistration.find(params[:id])
      authorize @registration
      @registration.update(dti_registration_params)
      if @registration.save
        redirect_to business_url(@registration.business), notice: "Registration updated successfully."
      else
        render :edit
      end
    end

    private
    def dti_registration_params
      params.require(:businesses_dti_registration).permit(:registration_number, :date_issued, :expiry_date)
    end
  end
end
