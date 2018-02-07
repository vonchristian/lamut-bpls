module BploSection
  class TricyclesController < ApplicationController
    def new
      @taxpayer = Taxpayer.friendly.find(params[:taxpayer_id])
      @tricycle = @taxpayer.tricycles.build
      @tricycle.addresses.build
      @tricycle.tricycle_permit_applications.build
      authorize @tricycle
    end

    def create
      @taxpayer = Taxpayer.friendly.find(params[:taxpayer_id])
      @tricycle = @taxpayer.tricycles.create(tricycle_params)
      authorize @tricycle
      if @tricycle.valid?
        @tricycle.save
          Tricycles::ApplicableTricycleFee.set_default_fees(@tricycle)
          Tricycles::ApplicableTricycleFee.set_additional_fees(@tricycle)
          Tricycles::ApplicableTricycleRequirement.set_default_requirements(@tricycle)
        redirect_to @tricycle, notice: "Tricycle Information saved successfully."
      else
        render :new
      end
    end

    private
    def tricycle_params
      params.require(:tricycle).permit(:mtop_number, :plate_number,
      addresses_attributes: [:barangay_id, :municipality_or_city_id, :province_id],
      tricycle_permit_applications_attributes: [:transaction_type, :application_date, :application_number])
    end
  end
end
