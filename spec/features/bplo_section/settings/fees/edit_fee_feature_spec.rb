require 'rails_helper'

feature 'Edit fee' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes' do
    fee = create(:fee, amount: 50, name: 'Polices Clearance', default_fee: false)
    visit bplo_section_settings_path
    click_link 'Edit Fee'
    expect(page).to have_content("Polices Clearance")
    fill_in 'Name', with: 'Police Clearance'
    fill_in 'Amount', with: 100
    check 'Default Fee'
    click_button 'Update Fee'

    expect(page).to have_content('updated successfully')
    expect(fee.name).to eql('Police Clearance')
    expect(fee.amount).to eql(100)
  end
end
