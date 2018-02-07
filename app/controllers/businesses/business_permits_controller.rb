module Businesses
  class BusinessPermitsController < ApplicationController
    def index
      @business = Business.friendly.find(params[:business_id])
    end
  end
end
