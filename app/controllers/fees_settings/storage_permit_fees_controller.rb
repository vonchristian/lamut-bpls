module FeesSettings
  class StoragePermitFeesController < ApplicationController
    def new
      @storage_permit_fee = Fees::StoragePermitFee.new
      authorize @storage_permit_fee
    end
    def create
      @storage_permit_fee = Fees::StoragePermitFee.create(storage_permit_fee_params)
      authorize @storage_permit_fee
      if @storage_permit_fee.save
        redirect_to bplo_section_settings_url, notice: "Storage Permit Fee created successfully."
      else
        render :new
      end
    end

    private
    def storage_permit_fee_params
      params.require(:fees_storage_permit_fee).permit(:minimum_value, :maximum_value, :amount, :name)
    end
  end
end
