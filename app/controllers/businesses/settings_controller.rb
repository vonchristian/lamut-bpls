module Businesses
  class SettingsController < ApplicationController
    def index
      @business = Business.friendly.find(params[:business_id])
    end
  end
end
