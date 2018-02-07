module BploSection
  class BusinessFeesController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @business_fee = @business.business_fees.build
      authorize @business_fee
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @business_fee = @business.business_fees.create(business_fee_params)
      authorize @business_fee
      if @business_fee.save
        redirect_to new_bplo_section_business_business_fee_url(@business), notice: 'Fee added successfully'
      else
        render :new
      end
    end

    private
    def business_fee_params
      params.require(:businesses_business_fee).permit(:fee_id)
    end
  end
end
