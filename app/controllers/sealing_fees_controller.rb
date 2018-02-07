class SealingFeesController < ApplicationController 
  def edit 
    @sealing_fee = Fees::SealingFee.find(params[:id])
  end

  def update 
    @sealing_fee = Fees::SealingFee.find(params[:id])
    @sealing_fee.update(sealing_fee_params)
    if @sealing_fee.save 
      redirect_to business_url(@sealing_fee.business), notice: "Sealing Fee updated successfully."
    else 
      render :edit 
    end 
  end 

  private 
  def sealing_fee_params
    params.require(:fees_sealing_fee).permit(:amount, :calendar_year)
  end 
end 