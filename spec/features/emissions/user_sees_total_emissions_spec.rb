require 'rails_helper'

feature 'user views their usage', %{
  As a user
  I want to see my total emissions
  So I can see my total impact
} do

  scenario 'user logs in and sees their total emissions' do
    user = FactoryGirl.create(:user)
    source = FactoryGirl.create(:carbon_source, conversion_factor: 2)
    FactoryGirl.create(:usage,
      user: user,
      carbon_source: source,
      amount_used: 14)
    FactoryGirl.create(:usage,
      user: user,
      carbon_source: source,
      amount_used: 10)

    sign_in_as(user)

    expect(page).to have_content("Total Emissions: 48.0 lbs CO2")
  end
end
