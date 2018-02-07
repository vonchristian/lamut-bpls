module BploSection
  module Settings 
    class ModeOfPaymentsController < ApplicationController
      def new 
        @mode_of_payment = BploSection::Settings::ModeOfPayment.new 
      end 
      def create
        @mode_of_payment = BploSection::Settings::ModeOfPayment.create(mode_of_payment_params)
        if @mode_of_payment.save
          redirect_to bplo_section_settings_url, notice: "Mode of payment saved successfully."
        else 
          render :new 
        end 
      end 

      private 
      def mode_of_payment_params
        params.require(:bplo_section_settings_mode_of_payment).permit(:mode)
      end 
    end 
  end 
end 