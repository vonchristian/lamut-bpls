class BusinessRequirementsController < ApplicationController
	def destroy
		@business_requirement = Businesses::BusinessRequirement.friendly.find(params[:id])
    authorize @business_requirement
		@verification = @business_requirement.verifications.for_current_year
		if @verification.present?
			@verification.destroy
		end
		redirect_to business_checklist_index_url(@business_requirement.business), alert: 'Verification removed successfully.'
	end
end
