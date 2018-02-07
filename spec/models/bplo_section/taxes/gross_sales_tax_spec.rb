require 'rails_helper'
module BploSection
  module Taxes
    describe GrossSalesTax, type: :model do
      describe 'associations' do
        it { is_expected.to belong_to :tax_type }
        it { is_expected.to belong_to :gross_sales_tax_business_category }
      end
      describe 'validations' do
        # it { is_expected.to validate_presence_of :minimum_gross_sale }
        # it { is_expected.to validate_presence_of :maximum_gross_sale }
        # it { is_expected.to validate_presence_of :tax_amount }
        # it { is_expected.to validate_numericality_of :tax_amount }
        # it { is_expected.to validate_numericality_of :minimum_gross_sale }
        # it { is_expected.to validate_numericality_of :maximum_gross_sale }
      end
      it "#amount_range" do
        gross_sales_tax = build(:gross_sales_tax, minimum_gross_sale: 1, maximum_gross_sale: 10)

        expect(gross_sales_tax.amount_range).to eql(1..10)
      end
    end
  end
end
