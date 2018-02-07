module Registrations
  class BirRegistrationsController < ApplicationController
    def edit
      @registration = Businesses::BirRegistration.find(params[:id])
      authorize @registration
    end
    def update
      @registration = Businesses::BirRegistration.find(params[:id])
      authorize @registration
      @registration.update(bir_registration_params)
      if @registration.save
        redirect_to business_url(@registration.business), notice: "Registration updated successfully."
      else
        render :edit
      end
    end

    private
    def bir_registration_params
      params.require(:businesses_bir_registration).permit(:registration_number, :date_issued, :expiry_date)
    end
  end
end
