class SpecialPermitApplicationForm
  include ActiveModel::Model
  attr_accessor :first_name,
  :middle_name,
  :last_name,
  :date_of_birth,
  :email,
  :contact_number,
  :sex,
  :address_sitio,
  :address_barangay,
  :address_municipality,
  :address_province,
  :special_permit_id,
  :number_of_days,
  :location,
  :start_date,
  :end_date
  def save
    ActiveRecord::Base.transaction do
      create_or_find_taxpayer
      create_special_permmit
    end
  end
  def create_or_find_taxpayer
    Taxpayer.find_or_create_by(last_name: last_name, first_name: first_name, middle_name: middle_name, sex: sex, email: email, contact_number: contact_number)
  end
  def find_taxpayer
    Taxpayer.find_by(last_name: last_name, first_name: first_name, middle_name: middle_name, sex: sex, email: email, contact_number: contact_number)
  end
  def create_special_permmit
    find_taxpayer.taxpayer_special_permits.create(number_of_days: number_of_days, location: location, special_permit_id: special_permit_id, start_date: start_date, end_date: end_date)
  end
  def find_application
    TaxpayerSpecialPermit.find_by(number_of_days: number_of_days, location: location, special_permit_id: special_permit_id, start_date: start_date, end_date: end_date)
  end
end
