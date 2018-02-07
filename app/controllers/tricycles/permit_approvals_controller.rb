module Tricycles
  class PermitApprovalsController < ApplicationController
    def new
      @permit = Tricycles::TricyclePermitApplication.find(params[:tricycle_permit_application_id])
      @approval = @permit.build_tricycle_permit_approval
    end
    def create
      @permit = Tricycles::TricyclePermitApplication.find(params[:tricycle_permit_application_id])
      @approval = @permit.create_tricycle_permit_approval(approval_params)
      @approval.tricycle = @permit.tricycle
      if @approval.valid?
        @approval.save
        set_tricycle_status
        redirect_to @permit.tricycle, notice: "Permit approved successfully."
      else
        render :new
      end
    end

    private
    def set_tricycle_status
      if @approval.tricycle_permit_application.new_application?
        @approval.tricycle.new_tricycle!
      elsif @approval.tricycle_permit_application.renew?
        @approval.tricycle.renewed!
      end
    end
    def approval_params
      params.require(:tricycles_tricycle_permit_approval).permit(:date_approved, :remarks, :permit_number)
    end
  end
end
