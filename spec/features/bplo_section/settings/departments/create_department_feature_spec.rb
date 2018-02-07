require 'rails_helper'

feature 'Create department' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    visit bplo_section_settings_path
    click_link "New Department"
    fill_in 'Name', with: "Philippine National Police (PNP)"
    click_button "Create Department"

    expect(page).to have_content('created successfully')
  end
end
