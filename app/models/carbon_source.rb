class CarbonSource < ActiveRecord::Base
  CATEGORIES = %w(Home Travel)
  SUBCATEGORIES = ["Heating", "Electric", "Cooking",
    "Personal Car", "Company Car"]

  validates :source, presence: true
  validates :conversion_factor, presence: true, numericality: true
  validates :conversion_units, presence: true
  validates :category, presence: true, inclusion: {in: CATEGORIES}
  validates :subcategory, inclusion: {in: SUBCATEGORIES}
end
