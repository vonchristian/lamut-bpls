class CollectionsController < ApplicationController
  def index
    @entries = Accounting::Entry.payment.includes(:debit_amounts, :credit_amounts, :commercial_document).page(params[:page]).per(30)
  end
  def show
    @entry = Accounting::Entry.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = Accounting::EntryPdf.new(@entry, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Assessment.pdf"
      end
    end
  end
  def destroy
    @entry = Accounting::Entry.find(params[:id])
    @entry.destroy
    redirect_to business_url(@entry.commercial_document), notice: "Assessment deleted successfully."
  end
end
