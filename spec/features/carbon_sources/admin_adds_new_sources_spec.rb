require 'rails_helper'

feature 'admin adds new carbon sources', %Q{
  As an admin
  I want to add new carbon sources
  So that users have accurate options to select from
} do

  scenario 'admin succesfully adds a new source' do
    admin = FactoryGirl.create(:admin_user)
    visit new_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Sign In'

    visit root_path

    click_on 'Admin Home'

    fill_in 'Source', with: "heating oil"
    fill_in 'Conversion factor', with: 0.010213
    fill_in 'Conversion units', with: 'tons CO2 / gallon'
    select 'Home', from: 'Category'
    select 'Heating', from: 'Subcategory'

    click_on 'Add new source'

    expect(page).to have_content('Heating oil added as carbon source')
    expect(page).to have_content('Add new carbon source')
    expect(page).to find_field('Source')
    expect(page).to find_field('Conversion Factor')
    expect(page).to find_field('Conversion Units')
    expect(page).to find_field('Category')
    expect(page).to find_field('Subcategory')
  end


  scenario 'admin enters invalid information and new source is not added'

  scenario 'non-admin user is unable to add new source'

end
