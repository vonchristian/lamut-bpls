require 'rails_helper'

describe UserPolicy do
  subject { UserPolicy.new(user, record) }
  let(:record) { create(:user) }
  context 'system_administrator' do
    let(:user) { create(:user, role: 'system_administrator') }

    it { is_expected.to permit_action(:create)}
    it { is_expected.to permit_action(:show)}
  end
  context 'bplo_officer' do
    let(:user) { create(:user, role: 'bplo_officer') }

    it { is_expected.to_not permit_action(:create)}
    it { is_expected.to_not permit_action(:show)}
  end
end
