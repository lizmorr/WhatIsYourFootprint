require 'rails_helper'

describe Emission do

  describe 'emissions_over_time_period' do
    context 'conversion_factor is 12.2 and amount used is 10' do
      it 'returns 122' do
        emission = Emission.new(12.2, 10, 5)
        expect(emission.emissions_over_time_period).to eq 122
      end
    end
  end

  describe 'daily_emissions' do
    context 'emissions over time period is 20 and number days is 5' do
      it 'returns 4' do
        emission = Emission.new(2, 10, 5)
        expect(emission.daily_emissions).to eq 4
      end
    end
  end

end
