require 'rails_helper'

module Fees
  describe FireSafetyInspectionFee do
    describe 'associations' do
      it { is_expected.to belong_to :business }
    end
  end
end
