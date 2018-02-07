module FireDepartment
  class PercentageCollectionsController < ApplicationController
    def new
      @entry = Accounting::Entry.find(params[:payment_id])
      @collection = @entry.build_fire_dept_collection
      @collection.build_fire_safety_inspection_fee
      @collection.build_storage_fee
      @collection.build_conveyance_clearance_fee
      @collection.build_installation_clearance_fee
      @collection.build_fire_code_fine
      @collection.build_construction_tax

    end
    def create
      @entry = Accounting::Entry.find(params[:payment_id])
      @collection = @entry.build_fire_dept_collection(collection_params)
      if @collection.valid?
        @collection.collector = current_user
        @collection.save
        redirect_to fire_department_collection_url(@collection), notice: "Payment saved successfully."
      else
        render :new
      end
    end

    private
    def collection_params
      params.require(:fire_dept_collection).permit(:entry_date, :reference_number, fire_safety_inspection_fee_attributes: [:amount],
      storage_fee_attributes: [:amount], conveyance_clearance_fee_attributes: [:amount], installation_clearance_fee_attributes: [:amount],
      fire_code_fine_attributes: [:amount], construction_tax_attributes: [:amount] )
    end
  end
end
