class CarbonSource < ActiveRecord::Base
  CATEGORIES = %w(Home Travel)
  SUBCATEGORIES = %w(Heating Electric Cooking Car)

  validates :source, presence: true
  validates :conversion_factor, presence: true, numericality: {
    greater_than: 0, message: "must be a positive number"
  }
  validates :conversion_units, presence: true
end
