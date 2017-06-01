App.game = App.cable.subscriptions.create "GameChannel",
  collection: -> $("[data-game-id]")

  connected: ->
    # Called when the subscription is ready for use on the server
    setTimeout =>
      @followCurrentRoom()
      @installPageChangeCallback()
    , 1000

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log("received", data)

  click: (posX, posY) ->

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on "turbolinks:load", => @followCurrentRoom()

  followCurrentRoom: ->
    if game_id = @collection().data('game-id')
      @perform 'follow', id: game_id
    else
      @perform 'unfollow'
