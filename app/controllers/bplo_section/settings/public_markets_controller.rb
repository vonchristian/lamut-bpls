module BploSection
  module Settings
    class PublicMarketsController < ApplicationController
      def new
        @public_market = PublicMarket.new
      end
      def create
        @public_market = PublicMarket.create(public_market_params)
        if @public_market.valid?
          @public_market.save
          redirect_to bplo_section_settings_path, notice: "Public Market created successfully"
        else
          render :new
        end
      end

      private
      def public_market_params
        params.require(:public_market).
        permit(:name, :address)
      end
    end
  end
end
