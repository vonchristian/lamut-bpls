require 'rails_helper'
module Taxpayers
  describe TaxpayerBusiness do
    describe 'associations' do 
      it { is_expected.to belong_to :taxpayer }
      it { is_expected.to belong_to :business }
    end
  end
end