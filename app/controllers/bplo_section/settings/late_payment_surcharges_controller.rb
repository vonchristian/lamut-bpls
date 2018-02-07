module BploSection
  module Settings
    class LatePaymentSurchargesController < ApplicationController
      def new
        @late_payment_surcharge = BploSection::Settings::LatePaymentSurcharge.new
        authorize @late_payment_surcharge
      end
      def create
        @late_payment_surcharge = BploSection::Settings::LatePaymentSurcharge.create(late_payment_surcharge_params)
        authorize @late_payment_surcharge
        if @late_payment_surcharge.save
          redirect_to bplo_section_settings_url, notice: "Late Payment Surchage rate saved successfully."
        else
          render :new
        end
      end

      private
      def late_payment_surcharge_params
        params.require(:bplo_section_settings_late_payment_surcharge).permit(:rate)
      end
    end
  end
end
