module Tricycles
  class PaymentsController < ApplicationController
    def new
      @tricycle = Tricycle.find(params[:tricycle_id])
      @entry = Accounting::Entry.new
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end
    def create
      @tricycle = Tricycle.find(params[:tricycle_id])
      @entry = Accounting::Entry.create(entry_params)
      @entry.commercial_document = @tricycle
      @entry.recorder = current_user
      @entry.transaction_type = 'payment'
      @entry.barangay = @tricycle.barangay
      if @entry.save
        redirect_to @tricycle, notice: 'Payment saved successfully.'
      else
        render :new
      end
    end

    private def entry_params
      params.require(:accounting_entry).permit(:reference_number, :description, :entry_date, credit_amounts_attributes: [:amount, :account_id, :id], debit_amounts_attributes: [:amount, :account_id, :id] )
    end
  end
end
