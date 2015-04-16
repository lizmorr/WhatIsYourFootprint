require 'rails_helper'

feature 'user signs in', %{
  As an admin
  I should have access to the admin menu
  So that I perform admin functions
} do
  scenario 'admin sees admin drop down' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit root_path

    expect(page).to have_content('Admin')
  end

  scenario 'non-admin user does not see admin drop down' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit root_path

    expect(page).to_not have_content('Admin')
  end
end
