module BploSection
  module Settings
    class InterestRatesController < ApplicationController
      def new
        @interest_rate = BploSection::Settings::InterestRate.new
        authorize @interest_rate
      end
      def create
        @interest_rate = BploSection::Settings::InterestRate.create(interest_rate_params)
        authorize @interest_rate
        if @interest_rate.save
          redirect_to bplo_section_settings_url, notice: "Late Payment Surchage rate saved successfully."
        else
          render :new
        end
      end

      private
      def interest_rate_params
        params.require(:bplo_section_settings_interest_rate).permit(:rate)
      end
    end
  end
end
