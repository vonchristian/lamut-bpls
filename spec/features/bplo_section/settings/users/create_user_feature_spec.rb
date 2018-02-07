require 'rails_helper'

feature 'Create user' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    visit bplo_section_settings_path
    click_link 'New User'
    department = create(:department, name: "PNP")
  end
  scenario 'with valid attributes' do

    fill_in 'First name', with: 'Von'
    fill_in 'Last name', with: 'Halip'
    fill_in 'Email', with: 'vc.halip@gmail.com'
    fill_in 'Password', with: '1111111111'
    fill_in 'Password confirmation', with: '1111111111'
    choose "PNP"
    choose "POLICE OFFICER"
    click_button 'Save Employee'


    expect(page).to have_content('created successfully')
  end
  scenario 'with invalid attributes' do
    click_button 'Save Employee'

    expect(page).to have_content("can't be blank")
  end
end
