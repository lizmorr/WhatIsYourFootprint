class AddCitationToCarbonSources < ActiveRecord::Migration
  def change
    add_column :carbon_sources, :citation, :string, null: :false
    add_column :carbon_sources, :citation_url, :string, null: :false
  end
end
