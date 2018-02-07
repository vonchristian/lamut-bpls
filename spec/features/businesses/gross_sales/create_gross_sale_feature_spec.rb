require 'rails_helper'

feature 'Add Gross Sale' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    Rails.application.load_seed
    gross_sales_tax_business_category = BploSection::Settings::GrossSalesTaxBusinessCategory.find_by(name: "Manufacturers, assemblers, re-packers, processors, brewers, distillers, rectifiers, and compounders of liquors, distilled spirits, and wines or manufacturers of any article of commerce of whatever kind in nature")
    gross_sales_tax_config = BploSection::Configurations::GrossSalesTaxConfig.find_by(tax_config: 'per_business')
    business = create(:business, gross_sales_tax_config: gross_sales_tax_config, gross_sales_tax_business_category: gross_sales_tax_business_category)
    visit business_path(business)
    click_link 'Enter Gross Sale'
    fill_in 'Amount', with: 100_000
    fill_in 'Calendar year', with: Date.today

    click_button 'Save Gross Sale'
    expect(page).to have_content('saved successfully')
  end
end
