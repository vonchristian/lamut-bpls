class AnalyticsController < ApplicationController 
  def index 
     @competetive_index_categories = BploSection::Settings::CompetetiveIndexCategory.all
  end 
end 