root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.Rock
  @_id: 0
  @_types: [
    'emerald'
    'jade'
    'opal'
    # 'ruby'
    # 'sapphire'
    # 'tiger-eye'
    # 'topaz'
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
    @_element = @createElement()
    @registerMouse()

  x: ->
    @_x

  y: ->
    @_y

  type: ->
    @_type

  setType: (type) ->
    @_type = type
    $(@_element).attr('data-rock-type', type)

  element: ->
    @_element

  createElement: ->
    $('<div />', {
      'id': 'rock-' + @_id
      'class': 'rock'
      'data-rock-x': @_x
      'data-rock-y': @_y
      'data-rock-type': @_type
    })

  clean: ->
    $(@_element).removeClass('selected')

  destroy: ->
    @setType(null)
    @clean()

  registerMouse: ->
    @registerMouseClicks()

  registerMouseClicks: (event) ->
    $element = $(@_element)
    $element.click =>
      if @_game.state == 'pick' && @_game.selectRock(@)
        $element.addClass('selected')
      else
        $element.removeClass('selected')

  @generate_id: ->
    @_id++

  @generate_type: ->
    @_types[Math.floor(Math.random() * @_types.length)]