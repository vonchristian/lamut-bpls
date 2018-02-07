class RetiredBusinessReportsController < ApplicationController
  def index
    if params[:barangay].present?
      @barangay = Addresses::Barangay.find(params[:barangay])
      @businesses = @barangay.businesses.closed
    else
      @businesses = Business.closed
    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Reports::RetiredBusinessReportPdf.new(@businesses, @barangay, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "DTI Report.pdf"
      end
    end
  end
end
