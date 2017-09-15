class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id
  validate :rcpt_blocked

  after_create :broadcast

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def rcpt
    conversation.rcpt(user)
  end

  private

  def broadcast
    ActionCable.server.broadcast(
      "messages_#{rcpt.id}",
      body: 'New message'
    )
  end

  def rcpt_blocked
    if rcpt.blocked?
      errors.add(:recipient, "blocked")
    end
  end
end
