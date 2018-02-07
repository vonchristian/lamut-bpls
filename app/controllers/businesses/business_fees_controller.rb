module Businesses
  class BusinessFeesController < ApplicationController
    def destroy
      @business_fee = Businesses::BusinessFee.find(params[:id])
      @business_fee.destroy
      redirect_to business_url(@business_fee.business), alert: "Fee removed successfully."
    end
  end
end
