module Businesses
  class PaymentsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @entry = Accounting::Entry.new
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @entry = Accounting::Entry.create(entry_params)
      @entry.commercial_document = @business
      @entry.recorder = current_user
      @entry.transaction_type = 'payment'
      @entry.barangay = @business.barangay
      if @entry.save
        redirect_to @business, notice: 'Payment saved successfully.'
      else
        render :new
      end
    end

    private def entry_params
      params.require(:accounting_entry).permit(:reference_number, :description, :entry_date, credit_amounts_attributes: [:amount, :account_id, :id], debit_amounts_attributes: [:amount, :account_id, :id] )
    end
  end
end
