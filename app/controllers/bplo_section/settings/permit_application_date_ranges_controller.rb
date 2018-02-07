module BploSection
  module Settings
    class PermitApplicationDateRangesController < ApplicationController
      def new
        @permit_application_date_range = BploSection::Settings::PermitApplicationDateRange.new
        authorize @permit_application_date_range
      end
      def create
        @permit_application_date_range = BploSection::Settings::PermitApplicationDateRange.create(permit_application_date_range_params)
        authorize @permit_application_date_range
        if @permit_application_date_range.save
          redirect_to bplo_section_settings_url, notice: "permit_application_date_range created successfully."
        else
          render :new
        end
      end

      private
      def permit_application_date_range_params
        params.require(:bplo_section_settings_permit_application_date_range).permit(:start_date, :end_date)
      end
    end
  end
end
