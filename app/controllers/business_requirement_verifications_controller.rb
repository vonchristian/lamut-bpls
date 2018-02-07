class BusinessRequirementVerificationsController < ApplicationController
  def create
    @verification = Businesses::BusinessRequirements::Verification.create(business_requirement_params)
    authorize @verification, :create?
    @verification.save
    redirect_to business_url(@verification.business_requirement.business), notice: "Business Requirement verified successfully."
  end

  private
  def business_requirement_params
    params.require(:businesses_business_requirements_verification).permit(:business_requirement_id)
  end
end
