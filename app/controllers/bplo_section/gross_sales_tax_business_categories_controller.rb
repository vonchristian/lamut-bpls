module BploSection
  class GrossSalesTaxBusinessCategoriesController < ApplicationController
    def show
      @business_category = BploSection::Settings::GrossSalesTaxBusinessCategory.friendly.find(params[:id])
    end
  end
end
