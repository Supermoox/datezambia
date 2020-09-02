class AddDetailsToPictures < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :new_coments, :integer
    add_column :pictures, :new_likes, :integer
  end
end
