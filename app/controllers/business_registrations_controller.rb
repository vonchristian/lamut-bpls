class BusinessRegistrationsController < ApplicationController
  respond_to :html
  def new
    @permit_application = PermitApplication.new
  end
  def create
    @permit_application = PermitApplication.new(permit_application_params)
    if @permit_application.valid?
      @permit_application.register
      respond_with @permit_application, location: business_path(id: @permit_application.business.id)
  else 
  	respond_with @permit_application
    end
  end

  private
  def permit_application_params
    params.require(:permit_application).permit(:public_market_vendor, :public_market_tenant_id, :business_tax_exempted, :application_number, :application_date,
    :business_name, :business_contact_number, :business_email, :business_capital,
    :ownership_type_id, :gross_sales_tax_business_category_id, :mode_of_payment_id,
    :transaction_type, :business_area, :employee_count, :street, :barangay_id,
    :municipality_or_city_id, :province_id, :taxpayer_first_name, :taxpayer_middle_name,
    :taxpayer_last_name, :taxpayer_contact_number, :taxpayer_sex, :taxpayer_street,
    :taxpayer_barangay, :taxpayer_province, :taxpayer_municipality_or_city,
    :business_area_rented, :monthly_rent, :lessor_full_name, :lessor_address,
    :lessor_contact_number)
  end
end
