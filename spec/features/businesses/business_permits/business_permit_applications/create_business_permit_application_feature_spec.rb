require 'rails_helper'
feature 'Create business permit application' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    business = create(:business)
    visit business_path(business)
    click_link 'New Business Permit Application'
  end
  scenario 'with valid attributes' do
    choose "New Application"
    fill_in 'Application Number', with: '0090001'
    fill_in 'Application Date', with: Date.today

    click_button 'Save Application'

    expect(page).to have_content('saved successfully')
  end
end
