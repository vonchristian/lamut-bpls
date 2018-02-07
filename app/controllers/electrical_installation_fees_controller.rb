class ElectricalInstallationFeesController < ApplicationController
  def edit 
    @electrical_installation_fee = Fees::ElectricalInstallationFee.find(params[:id])
  end

  def update
    @electrical_installation_fee = Fees::ElectricalInstallationFee.find(params[:id])
    @electrical_installation_fee.update(electrical_installation_fee_params)
    if @electrical_installation_fee.save 
      redirect_to business_url(@electrical_installation_fee.business), notice: "Occupancy Permit Fee updated successfully."
    else 
      render :edit 
    end 
  end 

  private 
  def electrical_installation_fee_params
    params.require(:fees_electrical_installation_fee).permit(:amount, :calendar_year)
  end
end