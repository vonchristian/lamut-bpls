class SpecialPermitsController < ApplicationController
  def index
    @special_permits = TaxpayerSpecialPermit.all
  end
  def show
    @special_permit = TaxpayerSpecialPermit.find(params[:id])
  end
end
