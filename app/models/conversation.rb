class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  has_many :messages, dependent: :destroy
  has_one :last_message, -> { limit(1).order('id DESC') }, class_name: 'Message'

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope :between, -> (sender_id, recipient_id) do
    where('(conversations.sender_id = ? AND conversations.recipient_id =?)
        OR (conversations.sender_id = ? AND conversations.recipient_id =?)',
         sender_id,recipient_id, recipient_id, sender_id)
  end

  def rcpt(current_user)
    return recipient if sender.id == current_user
    sender
  end
end
