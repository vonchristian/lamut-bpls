class ReportsController < ApplicationController
  def index
    @competetive_index_categories = BploSection::Settings::CompetetiveIndexCategory.all
    if params[:barangay_id].present?
      @barangay = Addresses::Barangay.find(params[:barangay_id])
    end
    @accounts =  Accounting::Account.accounts_receivables
    @from_date = params[:from_date] ? Time.parse(params[:from_date]) : Time.now.beginning_of_year
    @to_date = params[:to_date] ? Time.parse(params[:to_date]) : Time.now.end_of_year

    @registered_businesses = Business.registered({from_date: @from_date, to_date: @to_date})
    @renewed_businesses = Business.renewed({from_date: @from_date, to_date: @to_date})
    @closed_businesses = Business.closed_between({from_date: @from_date, to_date: @to_date})
    @mayors_permit_fee_balance = Accounting::Account.find_by(name: "Business Permit Fees").balance(from_date: @from_date, to_date: @to_date)

  end
end
