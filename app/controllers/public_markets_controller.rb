class PublicMarketsController < ApplicationController
  def show
    @public_market = PublicMarket.find(params[:id])
    respond_to do |format|
      format.xlsx
    end
  end
end
