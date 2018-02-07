class ZoningFeesController < ApplicationController
  def edit 
    @zoning_fee = Fees::ZoningFee.find(params[:id])
  end

  def update
    @zoning_fee = Fees::ZoningFee.find(params[:id])
    @zoning_fee.update(zoning_fee_params)
    if @zoning_fee.save 
      redirect_to business_url(@zoning_fee.business), notice: "Occupancy Permit Fee updated successfully."
    else 
      render :edit 
    end 
  end 

  private 
  def zoning_fee_params
    params.require(:fees_zoning_fee).permit(:amount, :calendar_year)
  end
end