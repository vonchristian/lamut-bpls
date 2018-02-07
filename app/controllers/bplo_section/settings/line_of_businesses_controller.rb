module BploSection
  module Settings
    class LineOfBusinessesController < ApplicationController
      def index
        @mayors_permit_fee_business_categories = BploSection::Settings::MayorsPermitFeeBusinessCategory.all
        @line_of_businesses = BploSection::Settings::LineOfBusiness.all
      end
      def new
        @line_of_business = BploSection::Settings::LineOfBusiness.new
        authorize @line_of_business
        @line_of_business.build_mayors_permit_fee
      end
      def create
        @line_of_business = BploSection::Settings::LineOfBusiness.create(line_of_business_params)
        authorize @line_of_business
        if @line_of_business.save
          redirect_to bplo_section_settings_url, notice: 'Line of business saved successfully.'
        else
          render :new
        end
      end
      def show
        @line_of_business = BploSection::Settings::LineOfBusiness.friendly.find(params[:id])
      end
      def edit
        @line_of_business = BploSection::Settings::LineOfBusiness.friendly.find(params[:id])
        authorize @line_of_business
      end
      def update
        @line_of_business = BploSection::Settings::LineOfBusiness.friendly.find(params[:id])
        authorize @line_of_business
        @line_of_business.update_attributes(line_of_business_params)
        if @line_of_business.save
          redirect_to bplo_section_settings_url, notice: "Line of business updated successfully."
        else
          render :new
        end
      end
      private
      def line_of_business_params
        params.require(:bplo_section_settings_line_of_business).permit(:name, :mayors_permit_fee_business_category_id, :gross_sales_tax_business_category_id, :has_storage_permit_fee, :competetive_index_category_id, mayors_permit_fee_attributes: [:amount], :required_document_ids =>[])
      end
    end
  end
end
