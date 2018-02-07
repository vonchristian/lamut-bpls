class BuildingPermitFeesController < ApplicationController
   def edit 
    @building_permit_fee = Fees::BuildingPermitFee.find(params[:id])
  end

  def update
    @building_permit_fee = Fees::BuildingPermitFee.find(params[:id])
    @building_permit_fee.update(building_permit_fee_params)
    if @building_permit_fee.save 
      redirect_to business_url(@building_permit_fee.business), notice: "Occupancy Permit Fee updated successfully."
    else 
      render :edit 
    end 
  end 

  private 
  def building_permit_fee_params
    params.require(:fees_building_permit_fee).permit(:amount, :calendar_year)
  end
end