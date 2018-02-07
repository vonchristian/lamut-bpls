require 'rails_helper'

feature 'Create fee' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_url
    click_link 'New Fee'

    fill_in 'Name', with: 'Police Clearance'
    fill_in 'Amount', with: 50
    check 'Default Fee'
    click_button 'Create Fee'

    expect(page).to have_content('created successfully')
    expect(Fee.count).to eql(1)
  end
end
