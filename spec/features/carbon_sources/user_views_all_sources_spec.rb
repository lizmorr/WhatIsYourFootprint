require 'rails_helper'

feature 'user views all potential carbon sources', %{
  As a user
  I want to see all potential carbon sources
  So I know what I should be tracking
} do

  scenario 'User can see all sources' do
    FactoryGirl.create(:carbon_source, name: 'Electricity')
    FactoryGirl.create(:carbon_source, name: 'Natural gas')
    detail_source = FactoryGirl.create(:carbon_source,
      name: 'Heating oil',
      conversion_factor: 22.4,
      units: 'gallons',
)

    visit carbon_sources_path

    expect(page).to have_content('Electricity')

    expect(page).to have_content('Heating oil')
    expect(page).to have_content('Conversion: 22.4 lbs CO2 / gallon')

    expect(page).to have_content('Natural gas')

    expect(page.body.index('Electricity') < page.body.index('Heating oil'))
    expect(page.body.index('Heating oil') < page.body.index('Natural gas'))
  end
end
