class AddUniquenessToNameInCarbonSources < ActiveRecord::Migration
  def change
    add_index :carbon_sources, :name, unique: true
  end
end
