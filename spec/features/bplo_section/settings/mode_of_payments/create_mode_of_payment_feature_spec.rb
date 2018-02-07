require 'rails_helper'

feature 'Create mode of payment' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_path
    click_link 'New Mode of Payment'
    fill_in 'Mode', with: 'Annually'

    click_button 'Save'
    expect(page).to have_content('saved successfully')
  end
end
