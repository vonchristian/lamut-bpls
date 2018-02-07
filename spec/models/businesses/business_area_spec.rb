require 'rails_helper'

module Businesses
  describe BusinessArea do
    describe 'assoctions' do
      it { is_expected.to belong_to :business }
      it { is_expected.to belong_to :sanitary_inspection_fee }
    end
    describe 'validations' do
      it { is_expected.to validate_presence_of :area }
      it { is_expected.to validate_numericality_of :area }
    end
  end
end
