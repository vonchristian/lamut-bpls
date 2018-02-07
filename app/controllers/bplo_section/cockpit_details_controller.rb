module BploSection
  class CockpitDetailsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @cockpit_detail = @business.build_cockpit_detail
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @cockpit_detail = @business.build_cockpit_detail(cockpit_detail_params)
      if @cockpit_detail.save
        redirect_to business_url(@business), notice: "Cockpit Detail saved successfully."
      else
        render :new
      end
    end

    private
    def cockpit_detail_params
      params.require(:cockpit_detail).permit(:promoter_count, :referee_count, :pit_manager_count, :bet_taker_count, :bet_manager_count, :gaffer_count, :cashier_count, :derby_count)
    end
  end
end
