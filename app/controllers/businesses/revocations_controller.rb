module Businesses
  class RevocationsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @revocation = Businesses::BusinessPermits::Revocation.new
      authorize @revocation
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @revocation = Businesses::BusinessPermits::Revocation.create(revocation_params)
      authorize @revocation
      if @revocation.save
        redirect_to business_url(@business), alert: "Business revoked successfully."
      else
        render :new
      end
    end

    private
    def revocation_params
      params.require(:businesses_business_permits_revocation).permit(:date, :business_id, :remarks)
    end
  end
end
