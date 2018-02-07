require 'rails_helper'

module Businesses
  describe BusinessFeePolicy do
    subject { Businesses::BusinessFeePolicy.new(user, record) }
    let(:record) { create(:gross_sale) }


    context 'bplo_officer' do
      let(:user) { create(:user, role: 'bplo_officer') }
      it { is_expected.to permit_action(:create)}
      it { is_expected.to permit_action(:new)}
    end

    context 'police_officer' do
      let(:user) { create(:user, role: 'police_officer') }
      it { is_expected.to_not permit_action(:create)}
      it { is_expected.to_not permit_action(:new)}
    end

    context 'system_administrator' do
      let(:user) { create(:user, role: 'system_administrator') }
      it { is_expected.to_not permit_action(:create)}
      it { is_expected.to_not permit_action(:new)}
    end
  end
end
