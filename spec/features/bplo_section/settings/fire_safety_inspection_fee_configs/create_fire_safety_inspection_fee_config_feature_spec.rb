require 'rails_helper'

feature 'Create Fire Safety Inspection Fee Config' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    visit bplo_section_settings_path
    click_link 'Set Fire Safety Inspection Fee Percentage'
  end
  scenario 'with valid attributes' do
    fill_in 'Percent', with: 0.10
    click_button "Save"

    expect(page).to have_content('saved successfully')
  end
end
