module Monitoring
  class BarangaysController < ApplicationController
    def show
      @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_year.beginning_of_day
      @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_year.end_of_day
      @barangay = Addresses::Barangay.find(params[:id])
      @businesses = @barangay.businesses.page(params[:page]).per(50)
    end
  end
end
