class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.integer :city_id
      t.integer :age
      t.string :sex

      t.timestamps
    end
  end
end
