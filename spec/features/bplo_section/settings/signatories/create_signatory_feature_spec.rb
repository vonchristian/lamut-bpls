require 'rails_helper'

feature 'Create signatory' do
  before(:each) do
    user = FactoryBot.create(:user, role: 'bplo_officer')
    login_as(user, :scope => :user)

    visit bplo_section_settings_url
    click_link 'New Signatory'
  end
  scenario 'with valid attributes' do
    fill_in 'First name', with: 'Mariano'
    fill_in 'Middle name', with: "B."
    fill_in 'Last name', with: 'Buyagawan Jr.'
    fill_in 'Designation', with: 'Municipal Mayor'

    click_button 'Create Signatory'

    expect(page).to have_content('created successfully')
    expect(BploSection::Settings::Signatory.count).to eql(1)
  end
  scenario 'with invalid attributes' do
    click_button 'Create Signatory'

    expect(page).to have_content("can't be blank")
  end
end
