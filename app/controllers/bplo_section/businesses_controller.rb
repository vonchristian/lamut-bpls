module BploSection
  class BusinessesController < ApplicationController
    def new
      @taxpayer = Taxpayer.friendly.find(params[:taxpayer_id])
      @business = @taxpayer.businesses.build
      authorize @business, :new?
      @business.build_business_area
      @business.addresses.build
      @business.build_rent
      @business.build_lessor
      @business.build_tin
      @business.build_employee_count
    end
    def create
      @taxpayer = Taxpayer.friendly.find(params[:taxpayer_id])
      @business = @taxpayer.businesses.create(business_params)
      authorize @business, :create?
      if @business.save
        @business.taxpayers << @taxpayer
        redirect_to business_url(@business), notice: "Business saved successfully."
        # ActionCable.server.broadcast 'businesses', html: render_to_string('businesses/partials/count', layout: false)
      else
        render :new
      end
    end

    def edit
      @business = Business.friendly.find(params[:id])
      @business.addresses.build
    end

    def update
      @business = Business.friendly.find(params[:id])
      @business.update_attributes(business_params)
      if @business.save
        redirect_to business_url(@business), notice: "Business updated successfully."
      else
        render :edit
      end
    end

    private
    def business_params
      params.require(:business).permit(:is_transient, :public_market_vendor, :public_market_tenant_id, :business_tax_exempted, :avatar, :name, :ownership_type_id, :mode_of_payment_id,:gross_sales_tax_business_category_id, :gross_sales_tax_config_id, :deals_only_with_essential_commodities,
                                       :business_area_attributes => [:area, :rented, :id],
                                       :employee_count_attributes => [:number, :id],
                                       :addresses_attributes => [:id, :street, :barangay_id, :municipality_or_city_id, :province_id],
                                       :rent_attributes => [:monthly_rent, :id],
                                       lessor_attributes: [:full_name, :address, :contact_number, :email, :id],
                                       tin_attributes: [:number, :id] )
    end
  end
end
