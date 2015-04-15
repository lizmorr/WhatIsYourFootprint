class AddUseReasonToUsages < ActiveRecord::Migration
  def change
    add_column :usages, :use_reason_id, :integer, null: false
  end
end
