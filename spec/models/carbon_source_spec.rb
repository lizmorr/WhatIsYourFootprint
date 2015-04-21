require 'rails_helper'

describe CarbonSource do
  it { should validate_presence_of(:name) }
  it { should have_valid(:name).when("Heating oil", "Electric") }
  it { should_not have_valid(:name).when("", nil) }

  it { should validate_presence_of(:conversion_factor) }
  it { should have_valid(:conversion_factor).when(0.023, 1) }
  it { should_not have_valid(:conversion_factor).when(nil, "small") }

  it { should validate_presence_of(:units) }
  it { should have_valid(:units).when("gallons") }
  it { should_not have_valid(:units).when(nil, "") }
end
