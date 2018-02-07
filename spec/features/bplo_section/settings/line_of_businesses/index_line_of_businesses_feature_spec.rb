require 'rails_helper'

feature "Index page of line_of_businesses" do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'logged in' do
    mayors_permit_fee_business_category = create(:mayors_permit_fee_business_category, name: "Retailers")
    line_of_business = create(:line_of_business, name: "Repair Shop", mayors_permit_fee_business_category: mayors_permit_fee_business_category)
    mayors_permit_fee = create(:mayors_permit_fee, amount: 100, line_of_business: line_of_business)
    visit bplo_section_settings_line_of_businesses_path

    expect(page).to have_content("Retailers")
    expect(page).to have_content("Repair Shop")

  end
end
