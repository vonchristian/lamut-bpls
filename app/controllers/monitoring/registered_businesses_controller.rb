module Monitoring
  class RegisteredBusinessesController < ApplicationController
    def index
      @barangay = Addresses::Barangay.find(params[:barangay_id])
      @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_day
      @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_day
      @businesses = @barangay.businesses.registered({from_date: @from_date, to_date: @to_date})
      respond_to do |format|
        format.pdf do
          pdf = Monitoring::RegisteredBusinessesPdf.new(@barangay, @businesses, @from_date, @to_date, @line_of_business = nil, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Registered Businesses.pdf"
        end
      end
    end
  end
end
