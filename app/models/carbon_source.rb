class CarbonSource < ActiveRecord::Base
  has_many :usages

  validates :name, presence: true, uniqueness: true
  validates :conversion_factor, presence: true, numericality: {
    greater_than: 0, message: "must be a positive number"
  }
  validates :units, presence: true

  def name_with_units
    "#{name} (#{units})"
  end

  def conversion_units
    if units == "feet"
      "lbs CO2 / foot"
    else
      "lbs CO2 / #{units.chop}"
    end
  end
end
