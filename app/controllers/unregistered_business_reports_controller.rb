class UnregisteredBusinessReportsController < ApplicationController
  def index
    if params[:barangay].present?
      @barangay = Addresses::Barangay.find(params[:barangay])
      @businesses = @barangay.businesses.unrenewed
    else
      @businesses = Business.unrenewed

    end
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Reports::UnregisteredBusinessReportPdf.new(@businesses, @barangay, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "DTI Report.pdf"
      end
    end
  end
end
