class CreateUsages < ActiveRecord::Migration
  def change
    create_table :usages do |t|
      t.integer :user_id, null: false
      t.integer :carbon_source_id, null: false
      t.decimal :amount_used, precision: 2, null: false
      t.string :units, null: false
      t.date :usage_start_date, null: false
      t.date :usage_end_date, null: false
      t.text :notes

      t.timestamps null: false
    end
  end
end
