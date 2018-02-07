module Businesses
  class FireSafetyInspectionFeeCollectionsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @fire_safety_inspection_fee = @business.fire_safety_inspection_fee_collections.build
      authorize @fire_safety_inspection_fee
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @fire_safety_inspection_fee = @business.fire_safety_inspection_fee_collections.create(fire_safety_inspection_fee_params)
      authorize @fire_safety_inspection_fee
      if @fire_safety_inspection_fee.save
        redirect_to business_url(@business), notice: "FSI Fee collected successfully."
      else
        render :new
      end
    end

    private
    def fire_safety_inspection_fee_params
      params.require(:businesses_fire_safety_inspection_fee_collection).permit(:date, :reference_number, :amount)
    end
  end
end
