class AnnualInspectionFeesController < ApplicationController
  def edit 
    @annual_inspection_fee = Fees::AnnualInspectionFee.find(params[:id])
  end

  def update
    @annual_inspection_fee = Fees::AnnualInspectionFee.find(params[:id])
    @annual_inspection_fee.update(annual_inspection_fee_params)
    if @annual_inspection_fee.save 
      redirect_to business_url(@annual_inspection_fee.business), notice: "Occupancy Permit Fee updated successfully."
    else 
      render :edit 
    end 
  end 

  private 
  def annual_inspection_fee_params
    params.require(:fees_annual_inspection_fee).permit(:amount, :calendar_year)
  end
end