class TemporaryBusinessPermitsController < ApplicationController
  def index
    @business_permits = Businesses::BusinessPermits::BusinessPermitApproval.all.page(params[:page]).per(50)
  end
  def show
    @business_permit = Businesses::BusinessPermits::BusinessPermitApproval.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = TemporaryBusinessPermitPdf.new(@business_permit, view_context)
        send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Business Permit.pdf"
      end
    end
  end
end
