class Usage < ActiveRecord::Base
  belongs_to :use_reason
  belongs_to :carbon_source
  belongs_to :user

  UNITS = ["gallons", "cubic feet", "kWhs"]

  validates :user, presence: true
  validates :carbon_source, presence: true
  validates :use_reason, presence: true
  validates :amount_used, presence: true, numericality: true
  validates :units, presence: true, inclusion: {in: UNITS}
  validates_date :usage_start_date
  validates :usage_start_date, presence: true
  validates_date :usage_end_date, presence: true
  validates :usage_end_date, presence: true

end
