require 'rails_helper'

module Businesses
  describe BusinessActivity do
    describe 'associations' do
      it { is_expected.to belong_to :business }
      it { is_expected.to belong_to :line_of_business }
      it { is_expected.to belong_to :storage_permit_fee }
      it { is_expected.to have_many :gross_sales }
    end
    describe 'delegations' do
      it { is_expected.to delegate_method(:mayors_permit_fee_amount).to(:line_of_business) }
    end
  end
end
