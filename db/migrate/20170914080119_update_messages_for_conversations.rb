class UpdateMessagesForConversations < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :receiver_id
    add_column :messages, :conversation_id, :integer
    add_index :messages, :conversation_id
  end
end
