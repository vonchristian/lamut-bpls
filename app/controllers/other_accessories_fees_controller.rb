class OtherAccessoriesFeesController < ApplicationController
   def edit 
    @other_accessories_fee = Fees::OtherAccessoriesFee.find(params[:id])
  end

  def update
    @other_accessories_fee = Fees::OtherAccessoriesFee.find(params[:id])
    @other_accessories_fee.update(other_accessories_fee_params)
    if @other_accessories_fee.save 
      redirect_to business_url(@other_accessories_fee.business), notice: "Occupancy Permit Fee updated successfully."
    else 
      render :edit 
    end 
  end 

  private 
  def other_accessories_fee_params
    params.require(:fees_other_accessories_fee).permit(:amount, :calendar_year)
  end
end