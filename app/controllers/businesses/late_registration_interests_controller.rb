module Businesses
  class LateRegistrationInterestsController < ApplicationController
    def create
      @business = Business.friendly.find(params[:business_id])
      if @business.late_registration?
        Businesses::LateRegistrationInterest.set_interest(@business)
        redirect_to @business, notice: "Interests assessed successfully."
      else
        redirect_to @business, alert: 'late_registration_interest not saved'
      end
    end
  end
end
