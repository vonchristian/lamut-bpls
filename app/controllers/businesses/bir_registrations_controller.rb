module Businesses
  class BirRegistrationsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @registration = @business.build_bir_registration
      authorize @registration
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @registration = @business.create_bir_registration(bir_registration_params)
      authorize @registration
      if @registration.save
        redirect_to @business, notice: "BIR Registration saved successfully."
      else
        render :new
      end
    end

    private
    def bir_registration_params
      params.require(:businesses_bir_registration).permit(:registration_number, :date_issued, :expiry_date)
    end
  end
end
