require 'rails_helper'

module Addresses
  describe MunicipalityOrCity do
    describe 'assoctions' do 
      it { is_expected.to belong_to :province }
      it { is_expected.to have_many :barangays }
    end 
  end 
end
