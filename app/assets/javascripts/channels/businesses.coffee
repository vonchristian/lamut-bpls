App.businesses = App.cable.subscriptions.create "BusinessesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
      $(".businesses #businesses_count").html(data.html)
