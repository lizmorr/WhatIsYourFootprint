require 'rails_helper'

feature 'admin edits use reason', %{
  As an admin
  I want to edit use reasons
  In case I made an error in entering
} do

  scenario 'Admin succesfully edits information about carbon source' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)
    FactoryGirl.create(:use_reason, name: 'Travel')

    visit admin_use_reasons_path

    click_link "Edit Travel"

    fill_in 'Name', with: 'Work'
    click_button 'Edit Reason'

    expect(page).to have_content("Work updated!")
    expect(page).to have_content('Work')
    expect(page).to_not have_content('Travel')
  end

  scenario 'Admin edits use reason with invalid information and fails' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)
    FactoryGirl.create(:use_reason, name: 'Travel')

    visit admin_use_reasons_path

    click_link "Edit Travel"

    fill_in 'Name', with: ''
    click_button 'Edit Reason'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'non-admin user is unable to edit use_reason' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    reason = FactoryGirl.create(:use_reason)

    visit edit_admin_use_reason_path(reason)

    expect(page).to have_content('You are not authorized to access that!')
  end
end
