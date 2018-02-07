module BploSection
  module Businesses
    class BusinessPermitApplicationsController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @permit_application = @business.business_permit_applications.build
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @permit_application = @business.business_permit_applications.create(permit_application_params)
        if @permit_application.save
          redirect_to @business, notice: "Permit application saved successfully."
        else
          render :new
        end
      end

      private
      def permit_application_params
        params.require(:businesses_business_permits_business_permit_application).permit(:application_number, :application_date, :transaction_type)
      end
    end
  end
end
