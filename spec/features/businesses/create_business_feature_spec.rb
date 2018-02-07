require 'rails_helper'
feature 'Create business' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end
  scenario 'with valid attributes', js: true do
    ownership_type = create(:ownership_type, name: "Corporation")
    mode_of_payment = create(:mode_of_payment, mode: "Annually")
    barangay = create(:barangay, name: 'Tukucan')
    municipality = create(:municipality_or_city, name: 'Tinoc')
    province = create(:province, name: 'Ifugao')
    taxpayer = create(:taxpayer)
    visit taxpayer_path(taxpayer)
    click_link 'New Business'
    fill_in 'Business Name', with: 'ITWORX'
    choose "Corporation"
    choose "Annually"
    fill_in 'Street/Sitio', with: 'Ababba'
    select 'Tukucan', from: 'business_addresses_attributes_0_barangay_id'
    select 'Tinoc', from: 'business_addresses_attributes_0_municipality_or_city_id'
    select 'Ifugao', from: 'business_addresses_attributes_0_province_id'
    fill_in 'TIN', with: '314-425-698-000'
    fill_in 'Business Area', with: 50
    check 'Rented'
    fill_in 'Monthly rent', with: 2000
    fill_in 'Full name', with: "Mario Brothers"
    fill_in 'Address', with: 'Dullafan'
    fill_in 'Contact number', with: '0093131'
    click_button "Save Business"

    expect(page).to have_content('saved successfully')
  end
end
