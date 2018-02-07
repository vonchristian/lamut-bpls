require 'rails_helper'

module Businesses
  describe BusinessFee do
    describe 'associations' do 
      it { is_expected.to belong_to :business }
      it { is_expected.to belong_to :fee }
    end
    describe 'validations' do 
      it { is_expected.to validate_uniqueness_of(:fee_id).scoped_to(:business_id) }
    end
  end
end