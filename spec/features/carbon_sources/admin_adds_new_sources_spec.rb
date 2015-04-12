require 'rails_helper'

feature 'admin adds new carbon sources', %Q{
  As an admin
  I want to add new carbon sources
  So that users have accurate options to select from
} do

  scenario 'admin succesfully adds a new source'

  scenario 'admin enters invalid informatio and new source is not added'

  scenario 'non-admin user is unable to add new source'

end
