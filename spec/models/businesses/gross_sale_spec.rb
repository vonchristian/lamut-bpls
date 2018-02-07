require 'rails_helper'

module Businesses
  describe GrossSale do
    describe 'associations' do
      it { is_expected.to belong_to :business_activity }
      it { is_expected.to belong_to :business }
    end

    describe 'validations' do
      it { is_expected.to validate_presence_of :amount }
      it { is_expected.to validate_numericality_of :amount }
      it { is_expected.to validate_presence_of :calendar_year }

      it ".once_per_year" do
        Rails.application.load_seed
        gross_sales_tax_business_category = BploSection::Settings::GrossSalesTaxBusinessCategory.find_by(name: "Manufacturers, assemblers, re-packers, processors, brewers, distillers, rectifiers, and compounders of liquors, distilled spirits, and wines or manufacturers of any article of commerce of whatever kind in nature")
        gross_sales_tax_config = BploSection::Configurations::GrossSalesTaxConfig.find_by(tax_config: 'per_business')
        business = create(:business, gross_sales_tax_config: gross_sales_tax_config, gross_sales_tax_business_category: gross_sales_tax_business_category)
        gross_sale1 = create(:gross_sale, calendar_year: Date.today, business: business)
        gross_sale2 = build(:gross_sale, calendar_year: Date.today, business: business)

        expect(gross_sale1).to be_valid
        expect(gross_sale2).to_not be_valid
      end
    end

  end
end
