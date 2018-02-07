class TricyclePermitsController < ApplicationController
  def index
    @permits = Tricycles::TricyclePermitApproval.all.page(params[:page]).per(50)
  end
  def show
    @permit = Tricycles::TricyclePermitApproval.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = TricyclePermitPdf.new(@permit, view_context)
        send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Business Permit.pdf"
      end
    end
  end
end
