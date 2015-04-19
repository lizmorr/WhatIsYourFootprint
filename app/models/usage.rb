class Usage < ActiveRecord::Base
  belongs_to :use_reason
  belongs_to :carbon_source
  belongs_to :user

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

  def time_period
    start_date = self.start_date.strftime("%m/%d/%Y")
    end_date = self.end_date.strftime("%m/%d/%Y")
    "#{start_date} - #{end_date}"
  end

  def all_source_info
    "#{amount_used} #{units} #{carbon_source.name}"
  end

  def category
    use_reason.name
  end

  def changeable_by?(user)
    user == self.user
  end
end
