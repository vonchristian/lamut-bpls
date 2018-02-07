require 'rails_helper'

module BploSection
  module Settings
    describe Signatory do
      describe 'validations' do
        it { is_expected.to validate_presence_of :first_name }
        it { is_expected.to validate_presence_of :middle_name }
        it { is_expected.to validate_presence_of :last_name }
        it { is_expected.to validate_presence_of :designation }
      end
    end
  end
end
