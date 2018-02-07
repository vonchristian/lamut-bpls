require 'rails_helper'

module BploSection
  module Settings 
    describe ModeOfPayment do
      describe 'associations' do 
        it { is_expected.to have_many :businesses }
      end
      describe 'validations' do 
        it { is_expected.to validate_presence_of :mode }
        it { is_expected.to validate_uniqueness_of :mode }
      end
    end
  end
end
