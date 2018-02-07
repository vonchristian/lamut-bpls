module Businesses
  module BusinessRequirements
    class IssuancesController < ApplicationController
      def new
        @business_requirement = Businesses::BusinessRequirement.friendly.find(params[:business_requirement_id])
        @issuance = @business_requirement.issuances.build
        authorize @issuance, :new?
      end
      def create
        @business_requirement = Businesses::BusinessRequirement.friendly.find(params[:business_requirement_id])
        @issuance = @business_requirement.issuances.create(issuance_params)
        authorize @issuance, :create?
        if @issuance.save
          redirect_to business_url(@business_requirement.business), notice: 'Document issued successfully'
        else
          render :new
        end
      end

      private
      def issuance_params
        params.require(:businesses_business_requirements_issuance).permit(:reference_number, :issue_date)
      end
    end
  end
end
