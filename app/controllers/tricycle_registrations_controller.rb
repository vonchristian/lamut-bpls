class TricycleRegistrationsController < ApplicationController
  respond_to :html
  def new
    @permit_application = TricycleRegistrationForm.new
  end
  def create
    @permit_application = TricycleRegistrationForm.new(permit_application_params)
    if @permit_application.valid?
      @permit_application.register
      respond_with @permit_application, location: tricycle_path(id: @permit_application.find_tricycle.id)
  else
  	respond_with @permit_application
    end
  end

  private
  def permit_application_params
    params.require(:tricycle_registration_form).permit(:taxpayer_first_name, :taxpayer_middle_name,
    :taxpayer_last_name, :taxpayer_contact_number, :taxpayer_sex, :taxpayer_street,
    :taxpayer_barangay, :taxpayer_province, :taxpayer_municipality_or_city, :application_date, :application_number, :transaction_type,
    :transaction_type, :mtop_number, :plate_number, :tricycle_organization_id)
  end
end
