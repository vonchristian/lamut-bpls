require 'rails_helper'

feature 'Create line of business' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    mayors_permit_fee_business_category = create(:mayors_permit_fee_business_category, name: "Manufacturers")
    visit bplo_section_settings_path
    click_link 'New Line Of Business'
    fill_in 'Name', with: 'Sari sari'
    select 'Manufacturers', from: 'select_line_of_business_business_category'
    check 'Has Storage Permit Fee'

    click_button 'Save Line Of Business'
    expect(page).to have_content('saved successfully')
  end
end
