require 'rails_helper'

module Addresses
  describe Barangay do
    describe 'assoctions' do 
      it { is_expected.to belong_to :municipality_or_city }
    end
  end
end
