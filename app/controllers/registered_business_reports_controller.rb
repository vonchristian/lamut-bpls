class RegisteredBusinessReportsController < ApplicationController
  def index
    if params[:barangay].present?
      @barangay = Addresses::Barangay.find(params[:barangay])
      @businesses = @barangay.businesses.registered
    else
      @businesses = Business.registered

    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Reports::RegisteredBusinessReportPdf.new(@businesses, @barangay, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Registered Businesses.pdf"
      end
    end
  end
end
