require 'rails_helper'

feature 'Show User' do

  before(:each) do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
  end

  scenario 'with a valid user' do
    user = create(:user, first_name: 'Von', last_name: 'Halip')
    visit bplo_section_settings_path
    click_link 'Von Halip'

    expect(page).to have_content('Von Halip')
  end
end
