module MessagesHelper
  def message_preview(message)
    body = message.body
    if body.size > 100
      return body[0..100].concat('...')
    end
    if message.user == current_user
      return 'You: ' + body
    end
    body
  end

  def td(message)
    tdclass = message.read ? '' : 'active'
    content_tag(:td, class: tdclass) do
      yield
    end
  end

  def message_sender(user)
    return  user.email + " (You)" if current_user == user
    user.email
  end
end
