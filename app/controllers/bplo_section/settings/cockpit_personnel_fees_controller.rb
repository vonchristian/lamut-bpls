module BploSection
  module Settings
    class CockpitPersonnelFeesController < ApplicationController
      def new
        @fee = CockpitPersonnelFee.new
        authorize @fee
      end
      def create
        @fee = CockpitPersonnelFee.create(fee_params)
        authorize @fee
        if @fee.save
          redirect_to bplo_section_settings_url, notice: 'Fee created successfully.'
        else
          render :new
        end
      end
      def edit
        @fee = CockpitPersonnelFee.find(params[:id])
        authorize @fee
      end
      def update
        @fee = CockpitPersonnelFee.find(params[:id])
        authorize @fee
        @fee.update(fee_params)
        if @fee.save
          redirect_to bplo_section_settings_url, notice: "Fee updated successfully."
        else
          render :edit
        end
      end

      private
      def fee_params
        params.require(:cockpit_personnel_fee).permit(:name, :amount)
      end
    end
  end
end
