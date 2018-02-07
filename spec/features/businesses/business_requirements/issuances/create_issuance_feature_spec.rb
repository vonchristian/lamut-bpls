require 'rails_helper'

feature 'Create issuance' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    business = create(:business)
    required_document = create(:required_document)
    business_requirement = create(:business_requirement, business: business, required_document: required_document)

    visit business_path(business)
    click_link 'Issue'
    fill_in 'Reference number', with: '9878432'
    fill_in 'Issue date', with: Date.today
    click_button "Issue Document"

    expect(page).to have_content('issued successfully')
  end
end
