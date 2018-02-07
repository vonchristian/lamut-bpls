module BploSection
  module Businesses
    class LateRegistrationInterestsController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @late_registration_interest = @business.late_registration_interests.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @late_registration_interest = @business.late_registration_interests.build(late_registration_interest_params)
        if @late_registration_interest.save
          redirect_to @business, notice: "Interest saved successfully."
        else
          render :new
        end
      end

      private
      def late_registration_interest_params
        params.require(:businesses_late_registration_interest).permit(:calendar_year, :amount)
      end
    end
  end
end
