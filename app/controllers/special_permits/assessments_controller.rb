module SpecialPermits
  class AssessmentsController < ApplicationController
    def new
      @special_permit = TaxpayerSpecialPermit.find(params[:special_permit_id])
      @assessment = Accounting::Entry.new
      @assessment.credit_amounts.build
      @assessment.debit_amounts.build

    end
    def create
      @special_permit = TaxpayerSpecialPermit.find(params[:special_permit_id])
      @assessment = Accounting::Entry.create(entry_params)
      @assessment.commercial_document = @special_permit
      @assessment.recorder = current_user
      @assessment.transaction_type = 'assessment'
      @assessment.barangay = @special_permit.taxpayer.barangay
      if @assessment.save
        redirect_to special_permit_url(@special_permit), notice: 'Assessment saved successfully.'
        @assessment.create_activity key: 'entry.created_at', owner: current_user
      else
        render :new
      end
    end

    private def entry_params
      params.require(:accounting_entry).permit(:reference_number, :description, :entry_date, credit_amounts_attributes: [:amount, :account_id, :id], debit_amounts_attributes: [:amount, :account_id, :id] )
    end
  end
  end
