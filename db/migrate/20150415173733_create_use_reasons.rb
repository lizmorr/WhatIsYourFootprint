class CreateUseReasons < ActiveRecord::Migration
  def change
    create_table :use_reasons do |t|
      t.string :name, null:false
    end
  end
end
