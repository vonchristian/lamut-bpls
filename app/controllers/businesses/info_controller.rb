module Businesses
  class InfoController < ApplicationController
    def index
      @business = Business.friendly.find(params[:business_id])
    end
  end
end
