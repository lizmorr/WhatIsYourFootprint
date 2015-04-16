require 'rails_helper'

feature 'admin adds new use reason', %{
  As an admin
  I want to add new use reasons
  So that users have accurate options to select from
} do

  scenario 'admin succesfully adds a use reason' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit admin_use_reasons_path

    fill_in 'Name', with: "Home"

    click_on 'Add new reason'

    expect(page).to have_content('Home added as new use reason')
  end

  scenario 'admin enters source with missing information and fails' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit admin_use_reasons_path

    click_on 'Add new reason'

    expect(page).to_not have_content('Home')
    expect(page).to have_content("Name can't be blank")
  end
end
