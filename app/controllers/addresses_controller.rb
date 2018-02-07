class AddressesController < ApplicationController
  def edit
    @address = Address.find(params[:id])
  end
  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    if @address.save
      redirect_to business_settings_url(@address.addressable), notice: "Address updated successfully"
    else
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:barangay_id, :street, :municipality_or_city_id, :province_id)
  end
end
