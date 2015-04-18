class RenameDatesInUsages < ActiveRecord::Migration
  def change
    rename_column :usages, :usage_start_date, :start_date
    rename_column :usages, :usage_end_date, :end_date    
  end
end
