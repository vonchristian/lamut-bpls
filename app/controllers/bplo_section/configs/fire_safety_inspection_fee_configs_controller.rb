module BploSection
  module Configs
    class FireSafetyInspectionFeeConfigsController < ApplicationController
      def new
        @fire_safety_inspection_fee_config = BploSection::Configurations::FireSafetyInspectionFeeConfig.new
      end
      def create
        @fire_safety_inspection_fee_config = BploSection::Configurations::FireSafetyInspectionFeeConfig.create(fire_safety_inspection_fee_config_params)
        if @fire_safety_inspection_fee_config.save
          redirect_to bplo_section_settings_url, notice: "Fire Safety Inspection Fee Config saved successfully."
        else
          render :new
        end
      end

      private
      def fire_safety_inspection_fee_config_params
        params.require(:bplo_section_configurations_fire_safety_inspection_fee_config).permit(:percent)
      end
    end
  end
end
