module MessagesHelper
  def message_preview(body)
    if body.size > 100
      return body[0..100].concat('...')
    end
    body
  end

  def td(message)
    tdclass = message.read ? '' : 'active'
    content_tag(:td, class: tdclass) do
      yield
    end
  end
end
