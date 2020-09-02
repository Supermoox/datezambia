class AddNewMessageToConversations < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :new_message, :boolean, null: false, default: false
  end
end
