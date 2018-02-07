module TreasuryDepartment
  class CollectionsController < ApplicationController
    def index
      if params[:search].present?
        @collections = Accounting::Entry.text_search(params[:search]).page(params[:page]).per(30)
      else
        @collections = Accounting::Entry.payment.all.order(entry_date: :desc).page(params[:page]).per(30)
      end
    end
    def show
      @collection = Accounting::Entry.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf do
          pdf = Accounting::PaymentPdf.new(@collection, view_context)
            send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Assessment.pdf"
        end
      end
    end
    def edit
      @collection = Accounting::Entry.find(params[:id])
    end
    def update
      @collection = Accounting::Entry.find(params[:id])
      @collection.update(collection_params)
      if @collection.save
        redirect_to treasury_department_collection_url(@collection), notice: "OR Number Updated successfully."
      else
        render :edit
      end
    end

    private
    def collection_params
      params.require(:accounting_entry).permit(:reference_number, :description, :entry_date, credit_amounts_attributes: [:amount, :account_id, :id], debit_amounts_attributes: [:amount, :account_id, :id] )
    end
  end
end
