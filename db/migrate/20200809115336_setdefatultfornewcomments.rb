class Setdefatultfornewcomments < ActiveRecord::Migration[5.1]
  def change
    change_column :pictures, :new_coments, :integer,  default: 0
    change_column :pictures, :new_likes, :integer, default: 0
  end
end

