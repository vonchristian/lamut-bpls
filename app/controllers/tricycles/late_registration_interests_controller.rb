module Tricycles
  class LateRegistrationInterestsController < ApplicationController
    def create
      @tricycle = Tricycle.find(params[:tricycle_id])
      if @tricycle.late_registration?
        Businesses::LateRegistrationInterest.set_interest(@tricycle)
        redirect_to @tricycle, notice: "Interests assessed successfully."
      else
        redirect_to @tricycle, alert: 'Interests not assessed!'
      end
    end
  end
end
