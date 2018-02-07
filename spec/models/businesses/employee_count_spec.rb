require 'rails_helper'
module Businesses
  describe EmployeeCount do
    describe 'associations' do 
      it { is_expected.to belong_to :business }
    end 
    describe 'validations' do 
      it { is_expected.to validate_presence_of :number }
      it { is_expected.to validate_numericality_of :number }
    end
  end
end
