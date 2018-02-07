module Businesses
  class BusinessActivitiesController < ApplicationController
    def new
      if params[:search].present?
        @line_of_businesses = BploSection::Settings::LineOfBusiness.text_search(params[:search])
      else
        @line_of_businesses = BploSection::Settings::LineOfBusiness.all
      end
      @business = Business.friendly.find(params[:business_id])
      @activity = @business.business_activities.build
      authorize @activity
    end
    def create
      @business = Business.friendly.find(params[:business_id])
      @activity = @business.business_activities.create(business_activity_params)
      authorize @activity
      if @activity.save
        redirect_to new_bplo_section_business_business_activity_url(@business), notice: "Line Of Business added successfully."
      else
        render :new
      end
    end
    def destroy
      @business_activity = Businesses::BusinessActivity.friendly.find(params[:id])
      authorize @business_activity
      @business_activity.destroy
      redirect_to business_url(@business_activity.business), notice: "Business Activity removed successfully."
    end
    private
    def business_activity_params
      params.require(:businesses_business_activity).permit(:line_of_business_id, :number_of_unit, :volume)
    end
  end
end
