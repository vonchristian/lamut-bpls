module BploSection
  class SettingsController < ApplicationController
    def index
      authorize :settings, :index?
      @mayors_permit_fee_business_categories = BploSection::Settings::MayorsPermitFeeBusinessCategory.all
      @line_of_businesses = BploSection::Settings::LineOfBusiness.page(params[:page]).per(3)
      @fees = Fee.all
      @sanitary_inspection_fees = Fees::SanitaryInspectionFee.all
      @storage_permit_fees = Fees::StoragePermitFee.all
      @users = User.all
      @departments = BploSection::Settings::Department.all
      @ownership_types = BploSection::Settings::OwnershipType.all
      @signatories = BploSection::Settings::Signatory.all
    end
  end
end
