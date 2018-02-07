require 'rails_helper'

module Businesses
  describe BusinessFeePolicy do
    subject { Businesses::BusinessFeePolicy.new(user, record) }
    let(:record) { create(:business_fee) }

    context 'bplo_officer' do
      let(:user) { create(:user, role: 'bplo_officer') }

      it { is_expected.to permit_action(:create)}
      it { is_expected.to permit_action(:new)}
    end
  end
end
