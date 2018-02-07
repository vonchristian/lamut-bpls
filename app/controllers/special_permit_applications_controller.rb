class SpecialPermitApplicationsController < ApplicationController
  def new
    @application = SpecialPermitApplicationForm.new
  end
  def create
    @application = SpecialPermitApplicationForm.new(special_permit_params)
    if @application.save
      redirect_to special_permit_url(id: @application.find_application.id), notice: "Application saved successfully."
    else
      render :new
    end
  end

  private
  def special_permit_params
    params.require(:special_permit_application_form).permit(:first_name, :middle_name, :last_name, :date_of_birth, :sex, :contact_number, :special_permit_id, :location, :number_of_days, :start_date, :end_date)
  end
end
