module Tricycles
  class TricyclePermitApplicationsController < ApplicationController
    def new
      @tricycle = Tricycle.find(params[:tricycle_id])
      @application = @tricycle.tricycle_permit_applications.build
    end
    def create
      @tricycle = Tricycle.find(params[:tricycle_id])
      @application = @tricycle.tricycle_permit_applications.create(application_params)
      if @application.save
        redirect_to @tricycle, notice: "Permit Application saved successfully."
      else
        render :new
      end
    end

    private
    def application_params
      params.require(:tricycles_tricycle_permit_application).permit(:application_date, :application_number, :transaction_type)
    end
  end
end
