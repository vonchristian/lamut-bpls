module BploSection
  class LineOfBusinessesController < ApplicationController
    def show
      @line_of_business = BploSection::Settings::LineOfBusiness.friendly.find(params[:id])
      if params[:barangay].present?
        @businesses = @line_of_business.businesses.in(Addresses::Barangay.find(params[:barangay]))

      else
        @businesses = @line_of_business.businesses
      end
      respond_to do |format|
        format.html
        format.pdf do
          pdf = Monitoring::RegisteredBusinessesPdf.new(@barangay=nil, @businesses, @from_date, @to_date, @line_of_business, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Line of Businesses.pdf"
        end
      end
    end
  end
end
