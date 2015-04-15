require 'rails_helper'

feature 'user views carbon source details', %{
  As a user
  I want to see the details of all carbon sources
  So I can understand more about them
} do

  scenario 'User can see details' do
    FactoryGirl.create(:carbon_source,
      source: 'Heating oil',
      conversion_factor: 0.01203,
      conversion_units: 'tons CO2/gallon',
      category: 'Home')

    visit carbon_sources_path
    click_link 'Heating oil'

    expect(page).to have_content('Heating oil')
    expect(page).to have_content('Category: Home')
    expect(page).to have_content('Conversion: 0.01203 tons CO2/gallon')
  end
end
