require 'rails_helper'
feature 'Create capital tax' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_url
    click_link 'Set Capital Tax'
    fill_in 'Rate', with: 0.02
    click_button 'Save Rate'

    expect(page).to have_content('saved successfully')
  end
end
