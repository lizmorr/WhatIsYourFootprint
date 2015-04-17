require 'rails_helper'

feature 'admin edits carbon sources', %{
  As an admin
  I want to edit new carbon sources
  In case information changes about them
} do

  scenario 'Admin succesfully edits information about carbon source' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)
    source = FactoryGirl.create(:carbon_source)

    visit admin_carbon_sources_path

    click_link "Edit #{source.name}"

    fill_in 'Conversion factor', with: 0.02
    click_button 'Edit Source'

    expect(page).to have_content("#{source.name} updated!")
    expect(page).to have_content('Conversion: 0.02')
  end

  scenario 'Admin edits carbon source with invalid information and fails' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)
    source = FactoryGirl.create(:carbon_source)

    visit admin_carbon_sources_path

    click_link "Edit #{source.name}"

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

    expect(page).to have_content('You are not authorized to access that!')
  end
end
