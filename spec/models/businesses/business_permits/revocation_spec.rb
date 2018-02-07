require 'rails_helper'

module Businesses
  module BusinessPermits
    describe Revocation do
      describe 'associations' do
        it {is_expected.to belong_to :business }
      end
      describe 'validations' do
        it { is_expected.to validate_presence_of :remarks }
      end
    end
  end
end 
