App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    node = $('.fa.fa-comment-o').next()
    messages = parseInt(node.text(), 10)
    if (isNaN(messages))
      messages = 0
    node.text((messages + 1) + ' NEW')
