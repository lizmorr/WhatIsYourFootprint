require 'rails_helper'

feature 'admin adds new carbon sources', %{
  As a user
  I want to enter my different sources of emissions
  So I can understand my usage of carbon sources
} do

  scenario 'user successfull adds new usage' do
    FactoryGirl.create(:carbon_source,
      name: "Unleaded Gas",
      conversion_units: "lbs / gallon")
    FactoryGirl.create(:use_reason, name: "Travel")

    user = FactoryGirl.create(:user)
    sign_in_as(user)

    click_on "Add personal usage"

    select "Unleaded Gas", from: "Source"
    fill_in 'Amount used', with: "10"
    select "gallons", from: "Units"
    select "Travel", from: "Use reason"
    fill_in "Start date", with: '01/15/2015'
    fill_in "End date", with: '02/15/2015'
    fill_in 'Notes', with: 'Started taking the T to work, so drove much less'

    click_on 'Add new usage'

    expect(page).to have_content('New personal usage added')
    expect(page).to have_content('10.0 gallons Unleaded Gas')
    expect(page).to have_content('Time Period: 01/15/2015 - 02/15/2015')
    expect(page).to have_content('Started taking the T to work, ' +
      'so drove much less')
    expect(page).to have_content('Use Reason: Travel')

  end

  scenario 'user enters usage with missing information and fails' do
    FactoryGirl.create(:carbon_source,
      name: "Unleaded Gas",
      conversion_units: "lbs / gallon")
    FactoryGirl.create(:use_reason, name: "Travel")

    user = FactoryGirl.create(:user)
    sign_in_as(user)

    click_on "Add personal usage"

    select "Unleaded Gas", from: "Source"
    fill_in "Start date", with: '15/15/2015'
    fill_in "End date", with: '02/15/2015'

    click_on 'Add new usage'

    expect(page).to have_content("Amount used can't be blank")
    expect(page).to have_content("Units can't be blank")
    expect(page).to have_content("Use reason can't be blank")
    expect(page).to have_content("Start date is not a valid date")
  end

  scenario 'viewer is unable to add new source' do
    visit usages_path

    expect(page).to have_content "You are not authorized to access that!"
  end

end
