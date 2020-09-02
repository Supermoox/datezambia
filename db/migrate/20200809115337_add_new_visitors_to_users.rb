class AddNewVisitorsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :new_visitors, :integer,  default: 0
  end
end
