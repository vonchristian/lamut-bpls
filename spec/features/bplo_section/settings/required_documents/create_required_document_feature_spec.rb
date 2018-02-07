require 'rails_helper'

feature "Create required document" do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    department = create(:department, name: "PNP")
    visit bplo_section_settings_path
    click_link "New Required Document"
    fill_in "Name", with: "Barangay Clearance"
    select 'PNP', from: 'required_document_department'
    check 'Default Requirement'

    click_button "Create Required Document"

    expect(page).to have_content('created successfully')
  end
end
