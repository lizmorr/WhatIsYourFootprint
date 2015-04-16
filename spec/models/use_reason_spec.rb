require 'rails_helper'

describe UseReason do
  it { should validate_presence_of(:name) }
  it { should have_valid(:name).when("home", "travel") }
  it { should_not have_valid(:name).when("", nil) }
end
