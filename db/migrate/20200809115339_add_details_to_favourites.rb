class AddDetailsToFavourites < ActiveRecord::Migration[5.1]
  def change
    add_column :favourites, :user_id, :integer
    add_column :favourites, :host_id, :integer
  end
end
