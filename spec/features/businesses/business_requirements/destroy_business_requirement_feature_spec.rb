require 'rails_helper'
feature 'Destroy business required_document' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'remove' do
    business = create(:business)
    required_document = create(:required_document, name: "BFAD Permit")
    business_requirement = create(:business_requirement, business: business, required_document: required_document)

    visit business_path(business)
    expect(page).to have_content("BFAD Permit")
    expect(business.business_requirements).to include(business_requirement)
    click_link 'Remove'
    expect(page).to have_content('removed successfully')
  end
end
