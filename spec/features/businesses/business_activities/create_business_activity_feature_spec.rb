require 'rails_helper'

feature 'Create business activity' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    mayors_permit_fee_business_category = create(:mayors_permit_fee_business_category)
    line_of_business = create(:line_of_business_with_mayors_permit_fee, name: "Sari sari sari", mayors_permit_fee_business_category: mayors_permit_fee_business_category)

    business = create(:business)
    visit business_path(business)

    click_link 'Add Business Activity'
    expect(page).to have_content("Sari sari sari")
    click_button 'Add'

    expect(page).to have_content('added successfully.')
    expect(business.line_of_businesses).to include(line_of_business)
  end
end
