require 'rails_helper'

module BploSection
  module Settings
    describe Department do
      describe 'validations' do
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_uniqueness_of :name }
      end
    end
  end
end
