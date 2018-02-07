class PermitApprovalsController < ApplicationController
  def new
    @business_permit_application = Businesses::BusinessPermits::BusinessPermitApplication.find(params[:business_permit_application_id])
    @approval = @business_permit_application.build_business_permit_approval
    @approval.build_business_tin_plate
  end
  def create
    @business_permit_application = Businesses::BusinessPermits::BusinessPermitApplication.find(params[:business_permit_application_id])

    @approval = @business_permit_application.create_business_permit_approval(approval_params)
    @approval.approver = current_user
    if @approval.save
      redirect_to business_url(@business_permit_application.business), notice: "Permit approved successfully."
    else
      render :new
    end
  end

  private
  def approval_params
    params.require(:businesses_business_permits_business_permit_approval).permit(:permit_number, :date_approved, business_tin_plate_attributes: [:number] )
  end
end
