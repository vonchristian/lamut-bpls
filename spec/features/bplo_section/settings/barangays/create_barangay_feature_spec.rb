require 'rails_helper'

feature 'Create barangay' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_path
    click_link 'New Barangay'
    fill_in 'Name', with: 'Poblacion'

    click_button 'Save Barangay'
    expect(page).to have_content('saved successfully')
  end
end
