class CreateCarbonSources < ActiveRecord::Migration
  def change
    create_table :carbon_sources do |t|
      t.string :source, null: false
      t.decimal :conversion_factor, null: false, precision: 6
      t.string :conversion_units, null: false
      t.string :category, null: false
    end
  end
end
