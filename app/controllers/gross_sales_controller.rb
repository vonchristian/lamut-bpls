class GrossSalesController < ApplicationController
  def edit
    @gross_sale = Businesses::GrossSale.find(params[:id])
  end
  def update
    @gross_sale = Businesses::GrossSale.find(params[:id])
    @gross_sale.update(gross_sale_params)
    if @gross_sale.valid?
      @gross_sale.save
      redirect_to business_info_index_url(@gross_sale.business), notice: "Gross Sale updated successfully."
    else
      render :edit
    end
  end

  private
  def gross_sale_params
    params.require(:businesses_gross_sale).permit(:amount, :calendar_year)
  end
end
