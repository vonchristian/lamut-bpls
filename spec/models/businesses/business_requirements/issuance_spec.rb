require 'rails_helper'

module Businesses
  module BusinessRequirements
    describe Issuance do
      describe 'associations' do
        it { is_expected.to belong_to :business_requirement }
      end
      describe 'validations' do
        it { is_expected.to validate_presence_of :reference_number }
        it { is_expected.to validate_presence_of :issue_date }
      end
    end
  end
end
