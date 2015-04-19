require 'rails_helper'

feature 'user deletes their usage', %{
  As a user
  I want to delete an entry
  In case I entered something mistakenly
} do

  scenario 'user deletes their entry' do
    source = FactoryGirl.create(:carbon_source, name: "Heating Oil")
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:usage,
      amount_used: 10,
      start_date: "02/15/2015",
      end_date: "02/15/2015",
      units: "gallons",
      carbon_source: source,
      user: user
    )

    sign_in_as(user)
    click_link "Delete this entry"

    expect(page).to have_content("Usage deleted")
    expect(page).to_not have_content("10.0 gallons Heating Oil")
    expect(page).to_not have_content("02/15/2015 - 02/15/2015")
  end
end
