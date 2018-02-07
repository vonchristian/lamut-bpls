module BploSection
  class LineOfBusinessSelectionsController < ApplicationController
    def new
      @business = Business.friendly.find(params[:business_id])
      @activity = @business.business_activities.build
      authorize @activity
    end
  end
end
