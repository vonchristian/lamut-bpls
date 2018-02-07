require 'rails_helper'

module Addresses
  describe Province do
    describe 'assoctions' do 
      it { is_expected.to have_many :municipality_or_cities }
    end
  end
end
