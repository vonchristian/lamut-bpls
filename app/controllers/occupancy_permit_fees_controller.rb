class OccupancyPermitFeesController < ApplicationController
  def edit 
    @occupancy_permit_fee = Fees::OccupancyPermitFee.find(params[:id])
  end

  def update
    @occupancy_permit_fee = Fees::OccupancyPermitFee.find(params[:id])
    @occupancy_permit_fee.update(occupancy_permit_fee_params)
    if @occupancy_permit_fee.save 
      redirect_to business_url(@occupancy_permit_fee.business), notice: "Occupancy Permit Fee updated successfully."
    else 
      render :edit 
    end 
  end 

  private 
  def occupancy_permit_fee_params
    params.require(:fees_occupancy_permit_fee).permit(:amount, :calendar_year)
  end
end