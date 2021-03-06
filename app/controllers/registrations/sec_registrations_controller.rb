module Registrations
  class SecRegistrationsController < ApplicationController
    def edit
      @registration = Businesses::SecRegistration.find(params[:id])
      authorize @registration
    end
    def update
      @registration = Businesses::SecRegistration.find(params[:id])
      authorize @registration
      @registration.update(sec_registration_params)
      if @registration.save
        redirect_to business_url(@registration.business), notice: "Registration updated successfully."
      else
        render :edit
      end
    end

    private
    def sec_registration_params
      params.require(:businesses_sec_registration).permit(:registration_number, :date_issued, :expiry_date)
    end
  end
end
