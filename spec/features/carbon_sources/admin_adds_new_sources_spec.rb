require 'rails_helper'

feature 'admin adds new carbon sources', %{
  As an admin
  I want to add new carbon sources
  So that users have accurate options to select from
} do

  scenario 'admin succesfully adds a new source' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit admin_carbon_sources_path

    fill_in 'Name', with: "Heating oil"
    fill_in 'Conversion factor', with: 0.010213
    fill_in 'Units', with: 'gallons'
    fill_in 'Citation', with: "EPA"
    fill_in 'Citation URL', with: "http://epa.gov/climatechange/ghgemissions/ind-assumptions.html"

    click_on 'Add new source'

    expect(page).to have_content('Heating oil added as carbon source')
    expect(page).to have_content('Conversion: 0.010213 lbs CO2 / gallon')
  end


  scenario 'admin enters source with missing information and fails' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit admin_carbon_sources_path

    fill_in 'Name', with: "Heating oil"
    click_on 'Add new source'

    expect(page).to_not have_content('Heating oil')
    expect(page).to have_content("Conversion factor can't be blank")
    expect(page).to have_content("Units can't be blank")
  end

  scenario 'non-admin user is unable to add new source' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit admin_carbon_sources_path

    expect(page).to have_content('You are not authorized to access that!')
  end

end
