module Tricycles
  class SurchargesController < ApplicationController
    def create
      @tricycle = Tricycle.find(params[:tricycle_id])
      if @tricycle.late_registration?
        Businesses::Surcharge.set_surcharge(@tricycle)
        redirect_to @tricycle, notice: "Surchage assessed successfully."
      else
        redirect_to @tricycle, alert: 'Surcharge not saved'
      end
    end
  end
end
