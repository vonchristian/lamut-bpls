require 'rails_helper'
module BploSection
  module LineOfBusinesses
    describe LineOfBusinessRequiredDocument, type: :model do
      describe 'associations' do
        it { is_expected.to belong_to :line_of_business }
        it { is_expected.to belong_to :required_document }
      end
    end
  end 
end
