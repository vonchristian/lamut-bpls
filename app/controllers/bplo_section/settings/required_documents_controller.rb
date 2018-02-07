module BploSection
  module Settings
    class RequiredDocumentsController < ApplicationController
      def new
        @required_document = BploSection::Settings::RequiredDocument.new
        authorize @required_document
      end
      def create
        @required_document = BploSection::Settings::RequiredDocument.create(required_document_params)
        authorize @required_document
        if @required_document.save
          redirect_to bplo_section_settings_url, notice: "Required Document created successfully"
        else
          render :new
        end
      end
      def edit
        @required_document = BploSection::Settings::RequiredDocument.friendly.find(params[:id])
        authorize @required_document
      end
      def update
        @required_document = BploSection::Settings::RequiredDocument.friendly.find(params[:id])
        authorize @required_document
        @required_document.update_attributes(required_document_params)
        if @required_document.save
          redirect_to bplo_section_settings_url, notice: "Required Document updated successfully."
        else
          render :new
        end
      end

      private
      def required_document_params
        params.require(:bplo_section_settings_required_document).permit(:name, :default_requirement, :department_id)
      end
    end
  end
end
