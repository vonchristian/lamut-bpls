  require 'rails_helper'
module BploSection
  module Settings
    describe LineOfBusiness do
      describe 'associations' do
        it { is_expected.to have_one :mayors_permit_fee }
        it { is_expected.to belong_to :mayors_permit_fee_business_category }
        it { is_expected.to belong_to :competetive_index_category }

        it { is_expected.to have_many :line_of_business_required_documents }
        it { is_expected.to have_many :required_documents }
      end
      describe 'validations' do
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_uniqueness_of :name }
      end
      describe 'nested attributes' do
        it { is_expected.to accept_nested_attributes_for(:mayors_permit_fee) }
      end
      describe 'delegations' do
        it { is_expected.to delegate_method(:amount).to(:mayors_permit_fee).with_prefix }
      end
    end
  end
end
