require 'rails_helper'

feature 'user edits their usage', %{
  As a user
  I want to edit my entries
  So I can correct any potential errors
} do

  scenario 'user successfully edits their entry' do
    source = FactoryGirl.create(:carbon_source, name: "Heating Oil")
    user = FactoryGirl.create(:user)
    usage = FactoryGirl.create(:usage, amount_used: 10,
      start_date: "02/15/2015", end_date: "02/15/2015", units: "gallons",
      carbon_source: source, user: user)

    sign_in_as(user)
    click_link "Edit this entry"

    fill_in "Amount used", with: 15
    fill_in "Start date", with: "01/15/2015"

    click_button "Edit usage"

    expect(page).to have_content("Usage updated!")
    expect(page).to have_content("15.0 gallons Heating Oil")
    expect(page).to_not have_content("10.0 gallons Heating Oil")
    expect(page).to have_content("01/15/2015 - 02/15/2015")
    expect(page).to_not have_content("02/15/2015 - 02/15/2015")
  end

  scenario 'user edits usage with invalid information and fails'
end
