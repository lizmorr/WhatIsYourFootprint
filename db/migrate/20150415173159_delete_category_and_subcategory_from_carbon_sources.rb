class DeleteCategoryAndSubcategoryFromCarbonSources < ActiveRecord::Migration
  def up
    remove_column :carbon_sources, :category
    remove_column :carbon_sources, :subcategory
  end

  def down
    add_column :carbon_sources, :category, null: false
    add_column :carbon_sources, :subcategory
  end
end
