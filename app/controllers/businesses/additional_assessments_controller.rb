module Businesses
  class AdditionalAssessmentsController < ApplicationController
    def new
      authorize [:businesses, :assessment], :new?
      @business = Business.friendly.find(params[:business_id])
      @assessment = Accounting::Entry.new
      @assessment.credit_amounts.build
      @assessment.debit_amounts.build

    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @assessment = Accounting::Entry.create(entry_params)
      @assessment.commercial_document = @business
      @assessment.recorder = current_user
      @assessment.transaction_type = 'assessment'
      @assessment.barangay = @business.barangay
      if @assessment.save
        PaymentSchedule.set(@business)
        redirect_to @business, notice: 'Additional Assessment saved successfully.'
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
