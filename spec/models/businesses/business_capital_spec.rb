require 'rails_helper'

module Businesses
  describe BusinessCapital do
    describe 'associations' do 
      it { is_expected.to belong_to :business }
    end
    describe 'validations' do 
      it { is_expected.to validate_presence_of :amount }
      it { is_expected.to validate_numericality_of :amount }
    end
  end
end
