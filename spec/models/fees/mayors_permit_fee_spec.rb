require 'rails_helper'

module Fees
  describe MayorsPermitFee do
    describe 'associations' do 
      it { is_expected.to belong_to :line_of_business }
    end
  end
end
