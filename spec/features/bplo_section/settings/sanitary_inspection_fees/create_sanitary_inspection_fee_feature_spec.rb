require 'rails_helper'

feature 'Create sanitary inspection fee' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_url
    click_link 'New Sanitary Inspection Fee'

    fill_in 'Minimum area', with: 50
    fill_in 'Maximum area', with: 100
    fill_in 'Amount', with: 50
    click_button 'Create Sanitary Inspection Fee'

    expect(page).to have_content('created successfully')
    expect(Fees::SanitaryInspectionFee.count).to eql(1)
  end
end
