module Reports
  class DilgController < ApplicationController
    def index
      @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_year
      @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_year
      @businesses = Business.created_at(from_date: @from_date, to_date: @to_date)
      respond_to do |format|
        format.html
        format.xlsx
        format.pdf do
          pdf = Reports::DilgPdf.new(@businesses, @from_date, @to_date, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "DTI Report.pdf"
        end
      end
    end
  end
end
