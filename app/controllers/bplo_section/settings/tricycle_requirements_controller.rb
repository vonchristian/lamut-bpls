module BploSection
  module Settings
    class TricycleRequirementsController < ApplicationController
      def new
        @requirement = TricycleRequirement.new
        authorize @requirement
      end
      def create
        @requirement = TricycleRequirement.create(requirement_params)
        authorize @requirement
        if @requirement.save
          redirect_to bplo_section_settings_url, notice: "Tricycle Requirement created successfully."
        else
          render :new
        end
      end
      def edit
        @requirement = TricycleRequirement.find(params[:id])
      end
      def update
        @requirement = TricycleRequirement.find(params[:id])
        @requirement.update(requirement_params)
        if @requirement.save
          redirect_to bplo_section_settings_url, notice: "Tricycle Requirement updated successfully."
        else
          render :edit
        end
      end

      private
      def requirement_params
        params.require(:tricycle_requirement).permit(:name, :department_id, :default_requirement)
      end
    end
  end
end
