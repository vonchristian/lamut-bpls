require 'rails_helper'

module Businesses
  module BusinessRequirements
    describe Verification do
      describe 'associations' do
        it { is_expected.to belong_to :business_requirement }
      end
    end
  end
end
