class AddReligionToSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :religion, :string
  end
end
