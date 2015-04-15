require 'rails_helper'

feature 'user views all potential carbon sources', %{
  As a user
  I want to see all potential carbon sources
  So I know what I should be tracking
} do

  scenario 'User can see all sources' do
    FactoryGirl.create(:carbon_source, source: 'Gasoline', category: 'Travel')

    FactoryGirl.create(:carbon_source, source: 'Electricity', category: 'Home')
    FactoryGirl.create(:carbon_source, source: 'Natural gas', category: 'Home')
    FactoryGirl.create(:carbon_source, source: 'Heating oil', category: 'Home')

    visit carbon_sources_path

    within('#Home_index') do
      expect(page).to have_content('Electricity')
      expect(page).to have_content('Heating oil')
      expect(page).to have_content('Natural gas')
    end

    expect(page.body.index('Electricity') < page.body.index('Heating oil'))
    expect(page.body.index('Heating oil') < page.body.index('Natural gas'))

    within('#Travel_index') do
      expect(page).to have_content('Gasoline')
    end
  end
end
