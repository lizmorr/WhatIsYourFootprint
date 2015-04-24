require 'rails_helper'

feature 'user views their usage', %{
  As a user
  I want to view an overview of my usage
  So I can see what I have entered
} do

  scenario 'user logs in and sees their usage with most recent on top' do
    user = FactoryGirl.create(:user)
    heating_oil = FactoryGirl.create(:carbon_source, name: "Heating Oil")
    electricity = FactoryGirl.create(:carbon_source, name: "Electricity")
    newer_source = FactoryGirl.create(
      :usage,
      user: user,
      carbon_source: electricity,
      end_date: 1.days.ago
    )
    older_source = FactoryGirl.create(
      :usage,
      user: user,
      carbon_source: heating_oil,
      end_date: 5.days.ago
    )

    sign_in_as(user)

    expect(page).to have_content("#{user.email}'s Emissions Overview")

    expect(page).to have_content(
      "#{newer_source.display_source_info_for_usage}")
    expect(page).to have_content("#{newer_source.display_time_period}")
    expect(page).to have_content("#{newer_source.category}")

    expect(page).to have_content(
      "#{older_source.display_source_info_for_usage}")
    expect(page).to have_content("#{older_source.display_time_period}")
    expect(page).to have_content("#{older_source.category}")

    expect(page.body.index(older_source.display_source_info_for_usage) >
      page.body.index(newer_source.display_source_info_for_usage))
  end

  scenario 'user only sees 10 usage entries per page' do
    user = FactoryGirl.create(:user)
    heating_oil = FactoryGirl.create(:carbon_source, name: "Heating Oil")
    electricity = FactoryGirl.create(:carbon_source, name: "Electricity")

    FactoryGirl.create_list(:usage, 10, user: user, carbon_source: electricity)
    FactoryGirl.create_list(
      :usage,
      10,
      user: user,
      carbon_source: heating_oil,
      created_at: 5.days.ago
    )

    sign_in_as(user)

    expect(page).to have_content("Electricity")
    expect(page).to_not have_content("Heating Oil")

    click_link "2"

    expect(page).to_not have_content("Electricity")
    expect(page).to have_content("Heating Oil")
  end

  scenario 'user does not see another person\'s entries' do
    user = FactoryGirl.create(:user, email: "person1@test.com")
    source = FactoryGirl.create(:usage, user: user)
    another_user = FactoryGirl.create(:user, email: "person2@test.com")

    sign_in_as(another_user)

    expect(page).to have_content("person2@test.com's Emissions Overview")
    expect(page).to_not have_content("#{source.display_source_info_for_usage}")
    expect(page).to_not have_content("#{source.display_time_period}")
    expect(page).to_not have_content("#{source.category}")
  end
end
