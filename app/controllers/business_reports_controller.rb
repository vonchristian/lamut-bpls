class BusinessReportsController < ApplicationController
  def index
    if params[:barangay].present?
      @barangay = Addresses::Barangay.find(params[:barangay])
      @businesses = @barangay.businesses
    else
      @businesses = Business.all
    end
    respond_to do |format|
      format.html
      format.xlsx
      format.pdf do
        pdf = Reports::BusinessReportPdf.new(@businesses, @barangay, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "DTI Report.pdf"
      end
    end
  end
end
