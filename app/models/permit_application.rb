class PermitApplication
  include ActiveModel::Model
  attr_accessor(
    :public_market_vendor,
    :public_market_tenant_id,
    :business_tax_exempted,
    :business_name,
    :business_area,
    :business_capital,
    :business_contact_number,
    :business_email,
    :employee_count,
    :transaction_type,
    :application_date,
    :application_number,
    :ownership_type_id,
    :mode_of_payment_id,
    :gross_sales_tax_business_category_id,
    :street,
    :barangay_id,
    :municipality_or_city_id,
    :province_id,
    :taxpayer_first_name,
    :taxpayer_middle_name,
    :taxpayer_last_name,
    :taxpayer_street,
    :taxpayer_barangay,
    :taxpayer_municipality_or_city,
    :taxpayer_province,
    :taxpayer_sex,
    :taxpayer_contact_number,
    :taxpayer_email,
    :business_area_rented,
    :monthly_rent,
    :lessor_full_name,
    :lessor_address,
    :lessor_contact_number
  )
  validates :barangay_id, :transaction_type, :business_name, :application_number, :application_date, :ownership_type_id, presence: true
  validates :mode_of_payment_id, :business_area, :employee_count, :street, presence: true
  validates :gross_sales_tax_business_category_id, presence: true
  validates :taxpayer_sex, :taxpayer_last_name, :taxpayer_middle_name, :taxpayer_first_name, :taxpayer_street, :taxpayer_municipality_or_city,
  :taxpayer_province, :taxpayer_contact_number, presence: true
  def register
    if valid?
      create_or_find_taxpayer
      create_or_find_taxpayer_address
      create_or_find_business
      create_or_find_business_owner
      create_or_find_business_area
      create_or_find_permit_application
      create_or_find_employee_count
      create_or_find_business_address
      create_or_find_business_capital
      create_or_find_lessor
      create_or_find_rent
    end
  end
  def business
    find_business
  end
  private

  def create_or_find_taxpayer
    Taxpayer.find_or_create_by(last_name: taxpayer_last_name, first_name: taxpayer_first_name, middle_name: taxpayer_middle_name, sex: taxpayer_sex, email: taxpayer_email, contact_number: taxpayer_contact_number)
  end
  def find_taxpayer
    Taxpayer.find_by(last_name: taxpayer_last_name, first_name: taxpayer_first_name, middle_name: taxpayer_middle_name, sex: taxpayer_sex, email: taxpayer_email, contact_number: taxpayer_contact_number)
  end

  def create_or_find_taxpayer_address
    taxpayer = find_taxpayer
    if taxpayer
      taxpayer.addresses.find_or_create_by(street: taxpayer_street, barangay_id: Addresses::Barangay.find_or_create_by(name: taxpayer_barangay).id,
                                                                  municipality_or_city_id: Addresses::MunicipalityOrCity.find_or_create_by(name: taxpayer_municipality_or_city).id,
                                                                  province_id: Addresses::Province.find_or_create_by(name: taxpayer_province).id)
    end
  end

  def create_or_find_business
    business = Business.find_or_create_by(public_market_vendor: public_market_vendor, public_market_tenant_id: public_market_tenant_id, business_tax_exempted: business_tax_exempted, name: business_name, ownership_type_id: ownership_type_id, mode_of_payment_id: mode_of_payment_id, gross_sales_tax_business_category_id: gross_sales_tax_business_category_id, email: business_email, contact_number: business_contact_number, business_type: transaction_type)
  end
  def find_business
    Business.find_by(name: business_name, ownership_type_id: ownership_type_id, mode_of_payment_id: mode_of_payment_id, gross_sales_tax_business_category_id: gross_sales_tax_business_category_id, email: business_email, contact_number: business_contact_number)
  end
  def create_or_find_business_owner
    Taxpayers::TaxpayerBusiness.find_or_create_by(taxpayer: create_or_find_taxpayer, business: find_business)
  end
  def create_or_find_business_area
    Businesses::BusinessArea.find_or_create_by(area: business_area, business: find_business, rented: business_area_rented)
  end
  def create_or_find_permit_application
    Businesses::BusinessPermits::BusinessPermitApplication.find_or_create_by(business: find_business, application_date: application_date, application_number: application_number, transaction_type: transaction_type)
  end
  def create_or_find_employee_count
    Businesses::EmployeeCount.find_or_create_by(business: find_business, number: employee_count)
  end

  def create_or_find_business_address
    business = find_business
    business.addresses.create(street: street, barangay_id: barangay_id, municipality_or_city_id: municipality_or_city_id, province_id: province_id)
  end
  def create_or_find_business_capital
    business = find_business
    business.create_business_capital(amount: business_capital)
  end
  def create_or_find_rent
    business = find_business
    business.create_rent(monthly_rent: monthly_rent)
  end

  def create_or_find_lessor
    business = find_business
    business.create_lessor(full_name: lessor_full_name, address: lessor_address, contact_number: lessor_contact_number)
  end
end
