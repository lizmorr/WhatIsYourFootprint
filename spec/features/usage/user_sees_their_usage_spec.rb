require 'rails_helper'

feature 'admin adds new carbon sources', %{
  As a user
  I want to view an overview of my usage
  So I can see what I have entered
} do

  scenario 'user logs in and sees their usage entries' do
    user = FactoryGirl.create(:user)
    source = FactoryGirl.create(:usage, user: user)

    sign_in_as(user)

    expect(page).to have_content("#{user.email}'s Carbon Usage")
    expect(page).to have_content("#{source.all_source_info}")
    expect(page).to have_content("#{source.time_period}")
    expect(page).to have_content("#{source.category}")
  end

  scenario 'user does not see another person\'s entries' do
    user = FactoryGirl.create(:user, email: "person1@test.com")
    source = FactoryGirl.create(:usage, user: user)
    another_user = FactoryGirl.create(:user, email: "person2@test.com")

    sign_in_as(another_user)

    expect(page).to have_content("#{another_user.email}'s Carbon Usage")
    expect(page).to_not have_content("#{source.all_source_info}")
    expect(page).to_not have_content("#{source.time_period}")
    expect(page).to_not have_content("#{source.category}")
  end
end
