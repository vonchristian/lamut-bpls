module Businesses
  module BusinessRequirements
    class VerificationsController < ApplicationController
      def new
        @business_requirement = Businesses::BusinessRequirement.friendly.find(params[:business_requirement_id])
        @verification = @business_requirement.verifications.build
      end
      def create
        @business_requirement = Businesses::BusinessRequirement.friendly.find(params[:business_requirement_id])
        @verification = @business_requirement.verifications.create(verification_params)
        if @verification.save
          redirect_to business_url(@business_requirement.business), notice: 'Document verified successfully'
        else
          render :new
        end
      end

      private
      def verification_params
        params.require(:businesses_business_requirements_verification).permit(:reference_number, :submission_date)
      end
    end
  end
end
