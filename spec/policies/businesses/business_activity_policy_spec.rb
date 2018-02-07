require 'rails_helper'

module Businesses
  describe BusinessFeePolicy do
    subject { Businesses::BusinessFeePolicy.new(user, record) }
    let(:record) { create(:business_activity) }

    context 'bplo_officer' do
      let(:user) { create(:user, role: 'bplo_officer') }

      it { is_expected.to permit_action(:create)}
      it { is_expected.to permit_action(:new)}
      it { is_expected.to permit_action(:destroy)}
    end
  end
end
