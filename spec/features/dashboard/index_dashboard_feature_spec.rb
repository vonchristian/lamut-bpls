require 'rails_helper'

feature 'Dashboard index' do
  scenario 'when logged in' do

    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    visit dashboard_index_path

    expect(page).to have_content 'BPLS Dashboard'
  end
end
