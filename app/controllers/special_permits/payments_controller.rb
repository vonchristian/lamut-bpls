module SpecialPermits
  class PaymentsController < ApplicationController
    def new
      @special_permit = TaxpayerSpecialPermit.find(params[:special_permit_id])
      @payment = Accounting::Entry.new
      @payment.credit_amounts.build
      @payment.debit_amounts.build

    end
    def create
      @special_permit = TaxpayerSpecialPermit.find(params[:special_permit_id])
      @payment = Accounting::Entry.create(entry_params)
      @payment.commercial_document = @special_permit
      @payment.recorder = current_user
      @payment.transaction_type = 'payment'
      @payment.barangay = @special_permit.taxpayer.barangay
      if @payment.save
        redirect_to special_permit_url(@special_permit), notice: 'Assessment saved successfully.'
        @payment.create_activity key: 'entry.created_at', owner: current_user
      else
        render :new
      end
    end

    private def entry_params
      params.require(:accounting_entry).permit(:reference_number, :description, :entry_date, credit_amounts_attributes: [:amount, :account_id, :id], debit_amounts_attributes: [:amount, :account_id, :id] )
    end
  end
  end
