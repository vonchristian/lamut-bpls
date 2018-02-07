require 'rails_helper'

feature 'Create storage permit fee' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_url
    click_link 'New Storage Permit Fee'

    fill_in 'Minimum value', with: 50
    fill_in 'Maximum value', with: 100
    fill_in 'Amount', with: 50
    click_button 'Create Storage Permit Fee'

    expect(page).to have_content('created successfully')
    expect(Fees::StoragePermitFee.count).to eql(1)
  end
end
