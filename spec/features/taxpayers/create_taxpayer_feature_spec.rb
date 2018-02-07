require 'rails_helper'
feature 'Create taxpayer' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    barangay = create(:barangay, name: 'Tukucan')
    municipality = create(:municipality_or_city, name: 'Tinoc')
    province = create(:province, name: 'Ifugao')
  end
  scenario 'with valid attributes' do
    visit taxpayers_path
    click_link "New Taxpayer"

    fill_in 'First Name', with: 'Von'
    fill_in 'Middle Name', with: 'Pinosan'
    fill_in 'Last Name', with: 'Halip'
    fill_in 'Contact Number', with: '09274173271'
    fill_in 'Email', with: 'vc.halip@gmail.com'
    choose 'Male'

    fill_in 'TIN', with: '425-698-314-000'
    fill_in 'Street/Sitio', with: 'Ababba'
    select 'Tukucan', from: 'taxpayer_addresses_attributes_0_barangay_id'
    select 'Tinoc', from: 'taxpayer_addresses_attributes_0_municipality_or_city_id'
    select 'Ifugao', from: 'taxpayer_addresses_attributes_0_province_id'

    click_button 'Save Taxpayer'

    expect(page).to have_content('saved successfully')
  end
end
