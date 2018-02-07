module Tricycles
  class FareAdjustmentFeesController < ApplicationController
    def new
      @tricycle = Tricycle.find(params[:tricycle_id])
      @fee = @tricycle.fare_adjustment_fees.build
    end
    def create
      @tricycle = Tricycle.find(params[:tricycle_id])
      @fee = @tricycle.fare_adjustment_fees.create(fee_params)
      if @fee.save
        redirect_to @tricycle, notice: "Fare Adjustment Fee saved successfully."
      else
        render :new
      end
    end

    private
    def fee_params
      params.require(:fees_fare_adjustment_fee).permit(:calendar_year, :amount)
    end
  end
end 
