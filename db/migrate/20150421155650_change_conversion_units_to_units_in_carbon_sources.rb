class ChangeConversionUnitsToUnitsInCarbonSources < ActiveRecord::Migration
  def change
    remove_column :carbon_sources, :conversion_units, :string, null: false
    add_column :carbon_sources, :units, :string, null: false
  end
end
