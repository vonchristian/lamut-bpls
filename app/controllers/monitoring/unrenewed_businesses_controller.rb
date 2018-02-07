module Monitoring
  class UnrenewedBusinessesController < ApplicationController
    def index

      @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_year
      @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_year
      if params[:barangay_id].present?
        @barangay = Addresses::Barangay.find(params[:barangay_id])
        @businesses = @barangay.businesses.unrenewed
      else
        @businesses = Business.unrenewed
      end
      respond_to do |format|
        format.html
        format.pdf do
          pdf = Monitoring::UnrenewedBusinessesPdf.new(@barangay, @businesses, @from_date, @to_date, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Registered Businesses.pdf"
        end
      end
    end
  end
end
