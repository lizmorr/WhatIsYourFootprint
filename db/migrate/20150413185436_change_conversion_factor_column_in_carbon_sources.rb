class ChangeConversionFactorColumnInCarbonSources < ActiveRecord::Migration
  def up
    change_column :carbon_sources, :conversion_factor, :float
  end

  def down
    change_column :carbon_sources, :conversion_factor, :decimal, null: false, precision: 6
  end
end
