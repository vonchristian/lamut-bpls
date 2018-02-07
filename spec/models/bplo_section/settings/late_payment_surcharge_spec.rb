require 'rails_helper'

module BploSection
  module Settings
    describe LatePaymentSurcharge do
      describe 'associations' do
      end
      describe 'validations' do
        it { is_expected.to validate_presence_of :rate }
        it { is_expected.to validate_numericality_of :rate }
      end
    end
  end
end
