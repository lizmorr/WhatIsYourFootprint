class Usage < ActiveRecord::Base
  belongs_to :use_reason
  belongs_to :carbon_source
  belongs_to :user

  delegate :conversion_factor, to: :carbon_source

  UNITS = ["gallons", "cubic feet", "kWhs"]

  validates :user, presence: true
  validates :carbon_source, presence: true
  validates :use_reason, presence: true
  validates :amount_used, presence: true, numericality: true
  validates :units, presence: true, inclusion: { in: UNITS }
  validates_date :start_date
  validates :start_date, presence: true
  validates_date :end_date, presence: true
  validates :end_date, presence: true

  def number_days
    if start_date == end_date
      1
    else
      (end_date - start_date).to_i
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
    "#{emission} lbs CO2"
  end

  def category
    use_reason.name
  end

  def changeable_by?(user)
    user == self.user
  end

  def self.user_usage(user)
    where(user: user).order(created_at: :desc)
  end

  def emission
    amount_used * conversion_factor
  end

  def self.user_total_emissions(user)
    usages = Usage.user_usage(user)
    total_emissions = 0
    usages.each { |usage| total_emissions += usage.emission }
    total_emissions
  end

  def daily_emission
    emission / number_days
  end

end
