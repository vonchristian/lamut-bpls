module Assessments
  class PaymentsController < ApplicationController
    def new
      @assessment = Accounting::Entry.find(params[:assessment_id])
      @entry = Accounting::Entry.new
      @entry.credit_amounts.build
      @entry.debit_amounts.build
    end
    def create
      @assessment = Accounting::Entry.find(params[:assessment_id])
      @entry = Accounting::Entry.create(entry_params)
      @entry.commercial_document = @assessment.commercial_document
      @entry.recorder = current_user
      @entry.transaction_type = 'payment'
      @entry.barangay = @assessment.commercial_document.barangay
      @entry.description = "Payment of fees and taxes"
      if @entry.save!
        redirect_to business_path(@assessment.commercial_document), notice: 'Payment saved successfully.'
          @assessment.paid!
      else
        render :new
      end
    end

    private def entry_params
      params.require(:accounting_entry).permit(:reference_number, :description, :entry_date, credit_amounts_attributes: [:amount, :account_id, :id, :commercial_document_id, :commercial_document_type], debit_amounts_attributes: [:amount, :account_id, :id, :commercial_document_type, :commercial_document_id] )
    end
  end
  end
