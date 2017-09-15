class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :all_except, ->(user) { where.not(id: user) }

  def conversations
    Conversation.where('sender_id = ? OR recipient_id = ?', id, id)
                .eager_load(:sender, :recipient, :last_message)
                .where('messages.id IS NOT NULL').order('messages.id DESC')
  end

  def conversations_ids
    Conversation.where('sender_id = ? OR recipient_id = ?', id, id).pluck(:id)
  end

  def unread_messages
    Message.eager_load(:conversation).where('conversations.sender_id = ? OR conversations.recipient_id = ?', id, id)
          .where('read IS NULL AND messages.user_id <> ?', id)
  end

  def admin?
    admin
  end

  def blocked?
    !!blocked
  end
end
