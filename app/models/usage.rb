class Usage < ActiveRecord::Base
  belongs_to :use_reason
  belongs_to :carbon_source
  belongs_to :user

  delegate :conversion_factor, :units, to: :carbon_source

  validates :user, presence: true
  validates :carbon_source, presence: true
  validates :use_reason, presence: true
  validates :amount_used, presence: true, numericality: true
  validates_date :start_date
  validates :start_date, presence: true
  validates_date :end_date, presence: true
  validates :end_date, presence: true

  def number_days
    if start_date == end_date
      1
    else
      (end_date - start_date).to_i + 1
    end
  end

  def display_time_period
    start_date = self.start_date.strftime("%m/%d/%Y")
    end_date = self.end_date.strftime("%m/%d/%Y")
    "#{start_date} - #{end_date}"
  end

  def display_source_info_for_usage
    "#{amount_used} #{units} #{carbon_source.name}"
  end

  def display_emission
    "#{emission.round(2)} lbs CO2"
  end

  def category
    use_reason.name
  end

  def changeable_by?(user)
    user == self.user
  end

  def self.user_usage(user)
    where(user: user).order(end_date: :desc, start_date: :desc)
  end

  def emission
    amount_used * conversion_factor
  end

  def daily_emission
    emission / number_days
  end

  def self.user_total_emissions(user)
    usages = Usage.user_usage(user)
    total_emissions = 0
    usages.each { |usage| total_emissions += usage.emission }
    total_emissions.round(2)
  end

  def self.usages_by_date(user, date)
    Usage.where("user_id = ? AND start_date <= ? AND end_date >= ?",
      user,
      date,
      date)
  end

  def self.total_daily_emissions(user, date)
    usages = Usage.usages_by_date(user, date)
    daily_total = 0
    usages.each { |usage| daily_total += usage.daily_emission }
    daily_total
  end

  def self.daily_emissions_summary(user, start_date, end_date)
    start_date = Date.parse(start_date.to_s)
    end_date = Date.parse(end_date.to_s)
    daily_emissions_hash = { "Type" => "Daily Emissions", "Data" => [] }
    start_date.step(end_date).each do |date|
      daily_emissions_hash["Data"] << {
        "Date" => date.strftime("%m/%d/%Y"),
        "Value" => total_daily_emissions(user, date)
      }
    end
    daily_emissions_hash
  end
end
