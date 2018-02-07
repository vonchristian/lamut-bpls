require 'rails_helper'

module BploSection
  module Taxes
    describe CapitalTaxPolicy do
      subject { BploSection::Taxes::CapitalTaxPolicy.new(user, record) }
      let(:record) { create(:capital_tax) }

      context 'bplo_officer' do
        let(:user) { create(:user, role: 'bplo_officer') }

        it { is_expected.to permit_action(:create)}
        it { is_expected.to permit_action(:new)}
      end
    end
  end
end
