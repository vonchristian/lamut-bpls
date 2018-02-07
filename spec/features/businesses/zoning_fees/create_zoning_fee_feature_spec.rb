require 'rails_helper'

feature 'Create building permit fee' do
  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    business = create(:business)
    visit businesses_path
    click_link business.name
    click_link 'Assess Zoning Fee'
  end
  scenario 'with valid attributes' do
    fill_in 'Amount', with: 500

    click_button 'Save Assessment'

    expect(page).to have_content('saved successfully')
  end

  scenario 'with invalid attributes' do
    click_button 'Save Assessment'

    expect(page).to have_content("can't be blank")
  end
end
