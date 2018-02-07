module BploSection
  module Settings
    class SignatoriesController < ApplicationController
      def new
        @signatory = BploSection::Settings::Signatory.new
        authorize @signatory
      end
      def create
        @signatory = BploSection::Settings::Signatory.create(signatory_params)
        authorize @signatory
        if @signatory.save
          redirect_to bplo_section_settings_url, notice: "Signatory created successfully."
        else
          render :new
        end
      end

      private
      def signatory_params
        params.require(:bplo_section_settings_signatory).permit(:first_name, :middle_name, :last_name, :designation)
      end
    end
  end
end
