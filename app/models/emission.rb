class Emission
  def initialize(conversion_factor, amount_used, number_days)
    @conversion_factor = conversion_factor
    @amount_used = amount_used
    @number_days = number_days
  end

  def emissions_over_time_period
    @amount_used * @conversion_factor
  end

  def daily_emissions
    emissions_over_time_period / @number_days
  end
end
