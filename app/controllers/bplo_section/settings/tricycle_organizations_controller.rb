module BploSection
  module Settings
    class TricycleOrganizationsController < ApplicationController
      def new
        @organization = TricycleOrganization.new
        authorize [:tricycles, :tricycle_organization]
      end
      def create
        @organization = TricycleOrganization.create(organization_params)
        authorize [:tricycles, :tricycle_organization]      
        if @organization.save
          redirect_to bplo_section_settings_url, notice: "Tricycle Requirement created successfully."
        else
          render :new
        end
      end
      def edit
        @organization = TricycleOrganization.find(params[:id])
      end
      def update
        @organization = TricycleOrganization.find(params[:id])
        @organization.update(organization_params)
        if @organization.save
          redirect_to bplo_section_settings_url, notice: "Tricycle Requirement updated successfully."
        else
          render :edit
        end
      end

      private
      def organization_params
        params.require(:tricycle_organization).permit(:name, :abbreviated_name)
      end
    end
  end
end
