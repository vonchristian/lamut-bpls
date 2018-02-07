module BploSection
  module Businesses
    class EngineeringPenaltiesController < ApplicationController
      def new
        @business = Business.friendly.find(params[:business_id])
        @engineering_penalty = @business.engineering_penalties.build
        authorize @engineering_penalty
      end
      def create
        @business = Business.friendly.find(params[:business_id])
        @engineering_penalty = @business.engineering_penalties.create(engineering_penalty_params)
        authorize @engineering_penalty
        if @engineering_penalty.save
          redirect_to business_url(@business), notice: "Engineering Penalty/Surcharge assessment saved successfully."
        else
          render :new
        end
      end

      private
      def engineering_penalty_params
        params.require(:fees_engineering_penalty).permit(:amount, :calendar_year)
      end
    end
  end
end
