require 'rails_helper'

module BploSection
  module Configurations
    describe FireSafetyInspectionFeeConfig do
      describe 'enums' do
        it { is_expected.to define_enum_for(:fee_type).with([:fixed_amount, :percent])}
      end
    end
  end
end
