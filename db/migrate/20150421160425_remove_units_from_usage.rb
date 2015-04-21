class RemoveUnitsFromUsage < ActiveRecord::Migration
  def up
    remove_column :usages, :units
  end
  def down
    add_column :usages, :units, :string, null: false
  end
end
