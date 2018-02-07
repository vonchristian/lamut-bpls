require 'rails_helper'
module BploSection
  module Configurations
    describe GrossSalesTaxConfig do
      describe 'enums' do
        it { is_expected.to define_enum_for(:tax_config).with([:per_business, :per_business_activity]) }
      end
    end
  end
end
