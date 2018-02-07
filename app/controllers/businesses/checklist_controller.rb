module Businesses
  class ChecklistController < ApplicationController
    def index
      @business = Business.friendly.find(params[:business_id])
      @verification = Businesses::BusinessRequirements::Verification.new
    end
  end
end
