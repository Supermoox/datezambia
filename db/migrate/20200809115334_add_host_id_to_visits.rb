class AddHostIdToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :host_id, :integer
  end
end
