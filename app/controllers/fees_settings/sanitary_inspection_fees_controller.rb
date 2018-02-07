module FeesSettings
  class SanitaryInspectionFeesController < ApplicationController
    def new
      @sanitary_inspection_fee = Fees::SanitaryInspectionFee.new
      authorize @sanitary_inspection_fee
    end
    def create
      @sanitary_inspection_fee = Fees::SanitaryInspectionFee.create(sanitary_inspection_fee_params)
      authorize @sanitary_inspection_fee
      if @sanitary_inspection_fee.save
        redirect_to bplo_section_settings_url, notice: "Sanitary Inspection Fee created successfully."
      else
        render :new
      end
    end

    private
    def sanitary_inspection_fee_params
      params.require(:fees_sanitary_inspection_fee).permit(:minimum_area, :maximum_area, :amount)
    end
  end
end
