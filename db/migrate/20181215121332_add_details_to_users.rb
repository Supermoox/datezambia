class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :about_me, :text
    add_column :users, :interested_men, :boolean
    add_column :users, :interested_women, :boolean
    add_column :users, :age, :integer
    add_column :users, :sex, :integer
    add_column :users, :marital_status, :integer
    add_column :users, :education, :integer
    add_column :users, :accommodation, :integer
    add_column :users, :height, :integer
    add_column :users, :weight, :integer
    add_column :users, :reason_friendship, :boolean
    add_column :users, :reason_penpal, :boolean
    add_column :users, :reason_marriage, :boolean
    add_column :users, :reason_romance, :boolean
    add_column :users, :reason_sex, :boolean
    add_column :users, :reason_travel, :boolean
    add_column :users, :income, :integer
    add_column :users, :habit_smoking, :boolean
    add_column :users, :habit_drinking, :boolean
    add_column :users, :children, :boolean
    add_column :users, :children_num, :integer
    add_column :users, :property_car, :boolean
    add_column :users, :property_house, :boolean
    add_column :users, :property_flat, :boolean
    add_column :users, :pet_dog, :boolean
    add_column :users, :pet_bird, :boolean
    add_column :users, :pet_cat, :boolean
    add_column :users, :pet_rabit, :boolean
    add_column :users, :religion, :integer
    add_column :users, :tribe, :integer
  end
end
