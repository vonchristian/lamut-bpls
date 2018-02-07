require 'rails_helper'

feature 'Create Business Requirement' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    business = create(:business)
    required_document = create(:required_document, name: 'BFAD Permit')
    visit business_path(business)
    click_link 'Add Additional Requirement'
    expect(page).to have_content('BFAD Permit')
    click_button 'Add'

    expect(page).to have_content('added successfully')
  end
end
