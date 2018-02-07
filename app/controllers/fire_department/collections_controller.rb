module FireDepartment
  class CollectionsController < ApplicationController
    def index
      if params[:search].present?
        @collections = FireDeptCollection.text_search(params[:search]).page(params[:page]).per(30)
      else
        @collections = FireDeptCollection.all.order(entry_date: :desc).page(params[:page]).per(30)
      end
    end
    def show
      @collection = FireDeptCollection.find(params[:id])
    end
    def edit
      @collection = FireDeptCollection.find(params[:id])
    end
    def update
      @collection = FireDeptCollection.find(params[:id])
      @collection.update(collection_params)
      if @collection.save
        redirect_to fire_department_collection_url(@collection), notice: "Updated successfully."
      else
        render :edit
      end
    end

    private
    def collection_params
      params.require(:fire_dept_collection).permit(:entry_date, :reference_number)
    end
  end
end
