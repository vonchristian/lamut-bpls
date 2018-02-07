module BploSection
  module Settings 
    class BusinessCategoriesController < ApplicationController
      def new 
        @business_category = BploSection::Settings::BusinessCategory.new 
      end 
      def create 
        @business_category = BploSection::Settings::BusinessCategory.create(business_category_params)
        if @business_category.save 
          redirect_to bplo_section_settings_url, notice: "Business Category created successfully."
        else 
          render :new 
        end 
      end 

      private 
      def business_category_params
        params.require(:bplo_section_settings_business_category).permit(:name)
      end 
    end 
  end 
end 