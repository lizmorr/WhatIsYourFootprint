class CarbonSource < ActiveRecord::Base
  has_many :usages

  validates :name, presence: true
  validates :conversion_factor, presence: true, numericality: {
    greater_than: 0, message: "must be a positive number"
  }
  validates :conversion_units, presence: true
end
