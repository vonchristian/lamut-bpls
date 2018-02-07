require 'rails_helper'
module BploSection
  module Settings
    describe TaxType do
      describe 'associations' do
        it { is_expected.to have_many :gross_sales_taxes }
      end
      describe "enums" do
        it { is_expected.to define_enum_for(:tax_type).with([:fixed_amount, :percentage, :percentage_with_tax_on_excess]) }
      end
    end
  end
end
