class EngineeringPenaltiesController < ApplicationController
  def edit 
    @engineering_penalty = Fees::EngineeringPenalty.find(params[:id])
  end 

  def update
    @engineering_penalty = Fees::EngineeringPenalty.find(params[:id])
    @engineering_penalty.update(penalty_params)
    if @engineering_penalty.save 
      redirect_to business_url(@engineering_penalty.business), notice: "Penalty updated successfully"
    else 
      render :edot 
    end 
  end 

  private 
  def penalty_params
    params.require(:fees_engineering_penalty).permit(:amount, :calendar_year)
  end 
end 