require 'rails_helper'

feature 'Create business permit approval' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    business = create(:business)
    business_permit_application = create(:business_permit_application, business: business)
    visit business_path(business)
    click_link 'Approve Business Permit Application'

    expect(page).to have_content 'approved successfully'
  end
end
