root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.Rock
  @_id: 0
  @_types: [
    'emerald'
    'jade'
    'opal'
    'ruby'
    'sapphire'
    'tiger-eye'
    'topaz'
  ]

  _id: 0
  _game: null
  _x: 0
  _y: 0

  constructor: (game, x, y) ->
    @_game = game
    @_x = x
    @_y = y
    @_id = Rock.generate_id()
    @_type = Rock.generate_type()
    @div = @createElement()
    @registerMouse()

  x: ->
    @_x

  y: ->
    @_y

  type: ->
    @_type

  createElement: ->
    $('<div />', {
      'id': 'rock-' + @_id,
      'class': 'rock ' + @_type,
      'data-board-row': 'data-board-row'
      'data-board-row-x': @_x,
      'data-board-row-y': @_y,
    })

  registerMouse: ->
    @registerMouseClicks()

  registerMouseClicks: (event) ->
    $div = $(@div)
    $div.click =>
      if @_game.state == 'pick' && @_game.select(@) 
        $div.toggleClass('selected')

  @generate_id: ->
    @_id++

  @generate_type: ->
    @_types[Math.floor(Math.random() * @_types.length)]