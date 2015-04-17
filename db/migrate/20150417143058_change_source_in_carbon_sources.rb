class ChangeSourceInCarbonSources < ActiveRecord::Migration
  def change
    rename_column :carbon_sources, :source, :name
  end
end
