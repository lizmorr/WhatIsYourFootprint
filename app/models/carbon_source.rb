class CarbonSource < ActiveRecord::Base
  validates :source, presence: true
  validates :conversion_factor, presence: true, numericality: true
  validates :conversion_units, presence: true
  validates :category, presence: true
end
