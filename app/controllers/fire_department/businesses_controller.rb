module FireDepartment
  class BusinessesController < ApplicationController
    def index
      if params[:search].present?
        @businesses = Business.text_search(params[:search]).page(params[:page]).per(30)
      else
        @businesses = Business.all.order(:name).page(params[:page]).per(50)
      end
    end
    def show
      @business = Business.friendly.find(params[:id])
    end
  end
end
