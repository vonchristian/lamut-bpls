require 'rails_helper'
feature 'Create capital tax' do
  before(:each) do
    user = create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_url
    click_link 'Set Late Payment Surcharge Rate'
    fill_in 'Rate', with: 0.25
    click_button 'Save Rate'

    expect(page).to have_content('saved successfully')
  end
  scenario 'with invalid attributes' do
    click_button 'Save Rate'

    expect(page).to have_content("can't be blank")
  end
end
