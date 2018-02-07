require 'rails_helper'

feature 'Create business fee' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    business = create(:business)
    fee = create(:fee, name: 'Police Clearance', amount: 50, default_fee: false)
    visit business_path(business)
    click_link 'Add Additional Fee'
    expect(page).to have_content('Police Clearance')
    expect(business.fees).to_not include(fee)
    click_button 'Add'

    expect(page).to have_content('added successfully')
  end
end
