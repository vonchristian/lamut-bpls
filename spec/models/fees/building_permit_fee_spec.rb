require 'rails_helper'

module Fees
  describe BuildingPermitFee do
    describe 'associations' do
      it { is_expected.to belong_to :business }
    end
    describe 'validations' do
      it { is_expected.to validate_presence_of :amount }
      it { is_expected.to validate_numericality_of :amount }
    end
    it ".for_current_year" do
      building_permit_fee = create(:building_permit_fee, calendar_year: Time.zone.now, amount: 500)
      building_permit_fee_2 = create(:building_permit_fee, calendar_year: Time.zone.now.prev_year, amount: 100)

      expect(Fees::BuildingPermitFee.for_current_year).to eql(500)
      expect(Fees::BuildingPermitFee.for_current_year).to_not eql(100)
    end
  end
end
