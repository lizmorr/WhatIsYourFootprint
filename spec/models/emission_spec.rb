require 'rails_helper'

describe Emission do

  describe 'emissions_over_time_period' do
    context 'conversion_factor is 12.2 and amount used is 10' do
      it 'returns 122' do
        source = FactoryGirl.create(:carbon_source, conversion_factor: "12.2")
        usage = FactoryGirl.create(:usage, carbon_source: source, amount_used: "10")
        emission = Emission.new(usage)
        expect(emission.emissions_over_time_period).to eq 122
      end
    end
  end

  describe 'daily_emissions' do
    context 'emissions over time period is 20 and number days is 5' do
      it 'returns 4' do
        source = FactoryGirl.create(:carbon_source, conversion_factor: "1")
        usage = FactoryGirl.create(:usage,
          amount_used: 20,
          start_date: "02/05/2015",
          end_date: "02/10/2015",
          carbon_source: source
        )
        emission = Emission.new(usage)
        expect(emission.daily_emissions).to eq 4
      end
    end
  end

end
