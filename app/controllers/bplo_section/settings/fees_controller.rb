module BploSection
  module Settings
    class FeesController < ApplicationController
      def new
        @fee = Fee.new
        authorize @fee
      end
      def create
        @fee = Fee.create(fee_params)
        authorize @fee
        if @fee.save
          redirect_to bplo_section_settings_url, notice: 'Fee created successfully.'
        else
          render :new
        end
      end
      def edit
        @fee = Fee.find(params[:id])
        authorize @fee
      end
      def update
        @fee = Fee.find(params[:id])
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
        params.require(:fee).permit(:name, :amount, :default_fee, :debit_account_id, :credit_account_id)
      end
    end
  end
end
