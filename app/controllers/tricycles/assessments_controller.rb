module Tricycles
  class AssessmentsController < ApplicationController
    def new
      authorize [:tricycles, :assessment], :new?
      @tricycle = Tricycle.find(params[:tricycle_id])
      @assessment = Accounting::Entry.new
      @assessment.credit_amounts.build
      @assessment.debit_amounts.build

    end
    def create
      @tricycle = Tricycle.find(params[:tricycle_id])
      @assessment = Accounting::Entry.create(entry_params)
      @assessment.commercial_document = @tricycle
      @assessment.recorder = current_user
      @assessment.transaction_type = 'assessment'
      @assessment.barangay = @tricycle.barangay
      if @assessment.save
        redirect_to @tricycle, notice: 'Assessment saved successfully.'
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
