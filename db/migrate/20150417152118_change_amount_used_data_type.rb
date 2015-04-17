class ChangeAmountUsedDataType < ActiveRecord::Migration
  def up
    change_column :usages, :amount_used, :float
  end

  def down
    change_column :usages, :amount_used, :decimal, precision: 2
  end
end
