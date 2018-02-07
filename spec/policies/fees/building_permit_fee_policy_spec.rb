require 'rails_helper'

module Fees
  describe BuildingPermitFeePolicy do
    subject { Fees::BuildingPermitFeePolicy.new(user, record) }
    let(:record) { create(:building_permit_fee) }

    context 'bplo_officer' do
      let(:user) { create(:user, role: 'bplo_officer') }

      it { is_expected.to_not permit_action(:create)}
      it { is_expected.to_not permit_action(:new)}
    end

    context 'system_administrator' do
      let(:user) { create(:user, role: 'system_administrator') }

      it { is_expected.to_not permit_action(:create)}
      it { is_expected.to_not permit_action(:new)}
    end

    context 'engineering_officer' do
      let(:user) { create(:user, role: 'engineering_officer') }

      it { is_expected.to permit_action(:create)}
      it { is_expected.to permit_action(:new)}
    end
  end
end
