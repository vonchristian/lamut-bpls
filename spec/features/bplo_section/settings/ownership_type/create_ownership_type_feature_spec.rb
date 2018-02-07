require 'rails_helper'
feature 'Create ownership type' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_path
    click_link 'New Ownership Type'
    fill_in 'Name', with: "Single Proprietorship"
    click_button 'Save'

    expect(page).to have_content('saved successfully')
  end
end
