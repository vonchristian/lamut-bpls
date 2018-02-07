require 'rails_helper'
module Businesses
  describe BusinessRequirement do
    describe 'associations' do
      it { is_expected.to belong_to :business }
      it { is_expected.to belong_to :required_document }
      it { is_expected.to have_many :verifications }
    end
    describe 'delegations' do
      it { is_expected.to delegate_method(:name).to(:required_document) }
      it { is_expected.to delegate_method(:default_requirement?).to(:required_document) }
      it { is_expected.to delegate_method(:department_name).to(:required_document) }
    end

    it '.verified' do
      verified_business_requirement = create(:business_requirement)
      unverified_business_requirement = create(:business_requirement)
      verification = create(:verification, business_requirement: verified_business_requirement, submission_date: Date.today)

      expect(Businesses::BusinessRequirement.verified).to include(verified_business_requirement)
      expect(Businesses::BusinessRequirement.verified).to_not include(unverified_business_requirement)

    end

    it "#verified" do
      verified_business_requirement = create(:business_requirement)
      unverified_business_requirement = create(:business_requirement)
      verification = create(:verification, business_requirement: verified_business_requirement, submission_date: Date.today)

      expect(verified_business_requirement.verified?).to be true
      expect(unverified_business_requirement.verified?).to be false
    end
  end
end
