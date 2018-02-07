require 'rails_helper'

module BploSection
  module Taxes
    describe CapitalTax do
      describe 'validations' do
        it { is_expected.to validate_presence_of :rate }
        it { is_expected.to validate_numericality_of :rate }
      end
    end
  end
end
