module BploSection
  module Settings
    class TricycleFeesController < ApplicationController
      def new
        @fee = TricycleFee.new
        authorize @fee
      end
      def create
        @fee = TricycleFee.create(fee_params)
        authorize @fee
        if @fee.save
          redirect_to bplo_section_settings_url, notice: 'Tricycle Fee created successfully.'
        else
          render :new
        end
      end
      def edit
        @fee = TricycleFee.find(params[:id])
      end
      def update
        @fee = TricycleFee.find(params[:id])
        @fee.update(fee_params)
        if @fee.save
          redirect_to bplo_section_settings_url, notice: "Tricycle Fee updated successfully."
        else
          render :edit
        end
      end

      private
      def fee_params
        params.require(:tricycle_fee).permit(:name, :amount, :default_fee, :debit_account_id, :credit_account_id)
      end
    end
  end
end
