require 'rails_helper'

feature 'admin adds new carbon sources', %{
  As an admin
  I want to edit new carbon sources
  In case information changes about them
} do

  scenario 'Admin succesfully edits information about carbon source' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)
    source = FactoryGirl.create(:carbon_source)

    click_link 'Admin Home'

    click_link "Edit #{source.source}"

    fill_in 'Conversion factor', with: 0.02
    click_button 'Edit Source'

    expect(page).to have_content("#{source.source} updated!")
    expect(page).to have_content('Conversion: 0.02')
  end

  scenario 'Admin edits carbon source with invalid information and fails' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)
    source = FactoryGirl.create(:carbon_source)

    click_link 'Admin Home'

    click_link "Edit #{source.source}"

    fill_in 'Conversion factor', with: 'small'
    fill_in 'Conversion units', with: ''
    click_button 'Edit Source'

    expect(page).to have_content('Conversion factor must be a positive number')
    expect(page).to have_content("Conversion units can't be blank")
    expect(page).to have_field('Conversion factor', with: 'small')
  end

  scenario 'non-admin user is unable to edit source' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    source = FactoryGirl.create(:carbon_source)

    visit edit_admin_carbon_source_path(source)

    expect(page).to have_content('Sorry, you were not authorized to ' +
      'access that page!')
  end
end
