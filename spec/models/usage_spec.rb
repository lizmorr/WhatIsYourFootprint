require 'rails_helper'

describe Usage do
  it { should belong_to(:carbon_source) }
  it { should validate_presence_of(:carbon_source) }

  it { should belong_to(:use_reason) }
  it { should validate_presence_of(:use_reason) }

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:amount_used) }
  it { should have_valid(:amount_used).when(3, 3.2) }
  it { should_not have_valid(:amount_used).when("three", nil) }

  it { should validate_presence_of(:start_date) }
  it { should have_valid(:start_date).when("01/02/2014", "12/02/2015") }
  it { should_not have_valid(:start_date).when("", nil, "13/13/2015") }

  it { should validate_presence_of(:end_date) }
  it { should have_valid(:end_date).when("01/02/2014", "12/02/2015") }
  it { should_not have_valid(:end_date).when("", nil, "13/13/2015") }

  describe 'changeable_by?' do
    context 'creator of usage signed in' do
      it 'returns true' do
        user = FactoryGirl.create(:user)
        usage = FactoryGirl.create(:usage, user: user)
        expect(usage.changeable_by?(user)).to eq true
      end
    end
    context 'user not associated with usage signed in' do
      it 'returns false' do
        user = FactoryGirl.create(:user)
        another_user = FactoryGirl.create(:user)
        usage = FactoryGirl.create(:usage, user: user)
        expect(usage.changeable_by?(another_user)).to eq false
      end
    end
  end

  describe 'number days' do
    context 'start and end date are same' do
      it 'returns 1' do
        usage = FactoryGirl.create(
          :usage,
          start_date: "02/15/2015",
          end_date: "02/15/2015")
        expect(usage.number_days).to eq 1
      end
    end
    context 'start and end date are different' do
      it 'returns 5' do
        usage = FactoryGirl.create(
          :usage,
          start_date: "02/15/2015",
          end_date: "02/20/2015"
        )
        expect(usage.number_days).to eq 5
      end
    end
  end

  describe 'display_time_period' do
    context 'shows time period' do
      it 'returns 02/15/2015 - 03/15/2015' do
        usage = FactoryGirl.create(
          :usage,
          start_date: "02/15/2015",
          end_date: "03/15/2015"
        )
        expect(usage.display_time_period).to eq "02/15/2015 - 03/15/2015"
      end
    end
  end

  describe 'display_source_info_for_usage' do
    context 'shows string of source info' do
      it 'returns 10 gallons Heating Oil' do
        source = FactoryGirl.create(
          :carbon_source,
          name: "Heating Oil",
          conversion_factor: 2,
          units: "gallons",
        )
        usage = FactoryGirl.create(
          :usage,
          amount_used: 10,
          carbon_source: source
        )
        expect(usage.display_source_info_for_usage).
          to eq "10.0 gallons Heating Oil"
      end
    end
  end
end
