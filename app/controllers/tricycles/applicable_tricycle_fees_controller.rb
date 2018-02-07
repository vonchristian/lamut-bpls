module Tricycles
  class ApplicableTricycleFeesController < ApplicationController
    def new
      @tricycle = Tricycle.find(params[:tricycle_id])
      @fee = @tricycle.applicable_tricycle_fees.build
      authorize @fee
    end
    def create
      @tricycle = Tricycle.find(params[:tricycle_id])
      @fee = @tricycle.applicable_tricycle_fees.create(fee_params)
      authorize @fee
      @fee.save
      redirect_to new_tricycle_applicable_tricycle_fee_path(@tricycle), notice: "Fee added successfully."
    end
    def destroy
      @fee = Tricycles::ApplicableTricycleFee.find(params[:id])
      authorize @fee
      @fee.destroy
      redirect_to @fee.tricycle, alert: "Fee removed successfully."
    end

    private
    def fee_params
      params.require(:tricycles_applicable_tricycle_fee).permit(:tricycle_fee_id)
    end
  end
end
