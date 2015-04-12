class AddSubcatagoryToCarbonSources < ActiveRecord::Migration
  def change
    add_column :carbon_sources, :subcategory, :string
  end
end
