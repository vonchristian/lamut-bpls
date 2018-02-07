require 'rails_helper'

module Businesses
  module BusinessPermits
    describe BusinessPermitApplication do
      describe 'associations' do
        it { is_expected.to belong_to :business }
        it { is_expected.to have_one :business_permit_approval }
      end
      describe 'validations' do
        it { is_expected.to validate_presence_of :application_number }
        it { is_expected.to validate_presence_of :application_date }
        it { is_expected.to validate_uniqueness_of :application_number }
      end
      describe 'enums' do
        it { is_expected.to define_enum_for(:transaction_type).with([:new_application, :renew]) }
      end
      it "#approved?" do
        business_permit_application = create(:business_permit_application)
        business_permit_approval = create(:business_permit_approval, business_permit_application: business_permit_application)

        expect(business_permit_application.approved?).to be true
      end

    end
  end
end
