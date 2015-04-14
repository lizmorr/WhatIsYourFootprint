require 'rails_helper'

feature 'admin adds new carbon sources', %Q{
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

  scenario 'Admin edits carbon source with invalid information and fails'

  scenario 'Non-admin user is unable to access page to edit'

end
