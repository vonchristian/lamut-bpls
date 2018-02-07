require 'rails_helper'

feature 'Verify Business Requirement' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    business = create(:business)
    required_document = create(:required_document)
    business_requirement = create(:business_requirement, business: business, required_document: required_document)

    visit business_path(business)
    click_link 'Verify'
    fill_in 'Reference number', with: '9878432'
    fill_in 'Submission date', with: Date.today
    click_button "Verify Document"

    expect(page).to have_content('verified successfully')
  end
end
