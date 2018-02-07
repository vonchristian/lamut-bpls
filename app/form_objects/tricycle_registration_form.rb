class TricycleRegistrationForm
  include ActiveModel::Model
  attr_accessor(
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
    :mtop_number,
    :plate_number,
    :tricycle_organization_id,
    :application_date,
    :application_number,
    :transaction_type
  )
  validates :taxpayer_sex, :taxpayer_last_name, :taxpayer_middle_name, :taxpayer_first_name,
            :tricycle_organization_id,
            :taxpayer_street, :taxpayer_barangay, :taxpayer_municipality_or_city,
            :taxpayer_province, :taxpayer_contact_number, :mtop_number,
            :plate_number, :application_date, :application_number, :transaction_type, presence: true

  def register
    if valid?
      create_or_find_taxpayer
      create_or_find_taxpayer_address
      create_or_find_tricycle
      create_or_find_tricycle_permit_appplication
      set_fees_and_requirements
    end
  end

  def find_tricycle
    Tricycle.find_by(mtop_number: mtop_number, plate_number: plate_number)
  end

  private
  def create_or_find_taxpayer
    Taxpayer.find_or_create_by(last_name: taxpayer_last_name, first_name: taxpayer_first_name, middle_name: taxpayer_middle_name, sex: taxpayer_sex, email: taxpayer_email, contact_number: taxpayer_contact_number)
  end
  def find_taxpayer
    Taxpayer.find_by(last_name: taxpayer_last_name, first_name: taxpayer_first_name, middle_name: taxpayer_middle_name, sex: taxpayer_sex, email: taxpayer_email, contact_number: taxpayer_contact_number)
  end
  def create_or_find_taxpayer_address
      find_taxpayer.addresses.find_or_create_by(street: taxpayer_street, barangay_id: Addresses::Barangay.find_or_create_by(name: taxpayer_barangay).id,
      municipality_or_city_id: Addresses::MunicipalityOrCity.find_or_create_by(name: taxpayer_municipality_or_city).id,
      province_id: Addresses::Province.find_or_create_by(name: taxpayer_province).id)
  end
  def create_or_find_tricycle
    tricycle = find_taxpayer.tricycles.find_or_create_by(mtop_number: mtop_number, plate_number: plate_number, tricycle_organization_id: tricycle_organization_id)
  end
  def create_or_find_tricycle_permit_appplication
    find_tricycle.tricycle_permit_applications.find_or_create_by(application_date: application_date, application_number: application_number, transaction_type: transaction_type)
  end
  def set_fees_and_requirements
    Tricycles::ApplicableTricycleFee.set_default_fees(find_tricycle)
    Tricycles::ApplicableTricycleFee.set_additional_fees(find_tricycle)
    Tricycles::ApplicableTricycleRequirement.set_default_requirements(find_tricycle)
  end
end
