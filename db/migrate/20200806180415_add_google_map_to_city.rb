class AddGoogleMapToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :google_map, :string
  end
end
