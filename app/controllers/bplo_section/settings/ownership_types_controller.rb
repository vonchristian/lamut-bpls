module BploSection
  module Settings
    class OwnershipTypesController < ApplicationController
      def new
        @ownership_type = BploSection::Settings::OwnershipType.new
        authorize @ownership_type
      end
      def create
        @ownership_type = BploSection::Settings::OwnershipType.create(ownership_type_params)
        authorize @ownership_type
        if @ownership_type.valid?
          @ownership_type.save
          redirect_to bplo_section_settings_url, notice: "Ownership Type saved successfully."
        else
          render :new
        end
      end

      private
      def ownership_type_params
        params.require(:bplo_section_settings_ownership_type).permit(:name)
      end
    end
  end
end
