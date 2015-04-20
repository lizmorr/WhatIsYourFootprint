class Emission
  def initialize(conversion_factor, amount_used, number_days)
    @conversion_factor = conversion_factor
    @amount_used = amount_used
    @number_days = number_days
  end

  def total_over_usage
    @amount_used * @conversion_factor
  end

  def daily_emissions
    total_over_usage / @number_days
  end

  def display_total_usage
    "#{total_over_usage} lbs CO2"
  end
end
