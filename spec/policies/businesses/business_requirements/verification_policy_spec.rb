require 'rails_helper'

module Businesses
  module BusinessRequirements
    describe VerificationPolicy do
      subject { Businesses::BusinessRequirements::VerificationPolicy.new(user, record) }
      let(:record) { create(:business_requirement) }

      context 'bplo_officer' do
        let(:user) { create(:user, role: 'bplo_officer') }

        it { is_expected.to permit_action(:create)}
        it { is_expected.to permit_action(:new)}
      end
    end
  end
end
