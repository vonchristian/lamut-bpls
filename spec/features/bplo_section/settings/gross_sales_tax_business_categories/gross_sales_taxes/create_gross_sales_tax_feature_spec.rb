require 'rails_helper'

feature 'Create gross sales tax' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    gross_sales_tax_business_category = create(:gross_sales_tax_business_category)
    visit bplo_section_gross_sales_tax_business_category_path(gross_sales_tax_business_category)
    click_link 'Add Gross Sale Tax'
    fill_in 'Minimum Gross Sale', with: 100
    fill_in 'Maximum Gross Sale', with: 1000
    fill_in 'Tax Amount', with: 10
    click_button 'Save Gross Sale Tax'

    expect(page).to have_content('created successfully')
  end
end
