class PlumbingInstallationFeesController < ApplicationController
  def edit 
    @plumbing_installation_fee = Fees::PlumbingInstallationFee.find(params[:id])
  end

  def update
    @plumbing_installation_fee = Fees::PlumbingInstallationFee.find(params[:id])
    @plumbing_installation_fee.update(plumbing_installation_fee_params)
    if @plumbing_installation_fee.save 
      redirect_to business_url(@plumbing_installation_fee.business), notice: "Occupancy Permit Fee updated successfully."
    else 
      render :edit 
    end 
  end 

  private 
  def plumbing_installation_fee_params
    params.require(:fees_plumbing_installation_fee).permit(:amount, :calendar_year)
  end
end