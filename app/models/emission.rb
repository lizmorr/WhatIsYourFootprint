class Emission
  def initialize(usage)
    @usage = usage
  end

  def emissions_over_time_period
    @usage.amount_used * @usage.conversion_factor
  end

  def daily_emissions
    emissions_over_time_period / @usage.number_days
  end
end
