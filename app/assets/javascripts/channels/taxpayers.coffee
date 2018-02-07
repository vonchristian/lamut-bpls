App.taxpayers = App.cable.subscriptions.create "TaxpayersChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $(".taxpayers #taxpayers_count").html(data.html)
