module BploSection
  class BusinessRequirementsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @business_requirement = @business.business_requirements.build
      authorize @business_requirement
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @business_requirement = @business.business_requirements.create(business_requirement_params)
      authorize @business_requirement
      if @business_requirement.save
        redirect_to new_bplo_section_business_business_requirement_path(@business), notice: "Requirement added successfully"
      else
        render :new
      end
    end
    def destroy
      @business_requirement = Businesses::BusinessRequirement.friendly.find(params[:id])
      authorize @business_requirement
      @business_requirement.destroy
      redirect_to business_url(@business_requirement.business), notice: "Business requirement removed successfully."
    end
    private
    def business_requirement_params
      params.require(:businesses_business_requirement).permit(:required_document_id)
    end
  end
end
