root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.Rock
  @_id: 0
  @_types: ['emerald', 'ruby', 'sapphire']

  _id: 0
  _x: 0
  _y: 0

  constructor: (x, y) ->
    @_id = Rock.generate_id()
    @_type = Rock.generate_type()
    @_x = x
    @_y = y
    @div = @createElement()
    @registerMouse()

  x: ->
    @_x

  y: ->
    @_y

  createElement: ->
    # Utils.createLi('rock-' + @_id, 'rock', 0, 0, 50, 50)
    $('<div></div>', {
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
      $div.toggleClass('selected')
      console.log { 'x': @_x, 'y': @_y }

  @generate_id: ->
    @_id++

  @generate_type: ->
    @_types[Math.floor(Math.random() * @_types.length)]