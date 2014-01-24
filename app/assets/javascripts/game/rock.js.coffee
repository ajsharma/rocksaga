root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.Rock
  @_id: 0
  _id: 0
  _x: 0
  _y: 0

  constructor: (x, y) ->
    @_id = Rock.id()
    @_x = x
    @_y = y
    @div = @createElement()
    @registerMouse()

  createElement: ->
    Utils.createLi('rock-' + @_id, 'rock', 0, 0, 50, 50)

  registerMouse: ->
    @registerMouseClicks()

  registerMouseClicks: (event) ->
    $div = $(@div)
    $div.click =>
      $div.toggleClass('selected')
      console.log { 'x': @_x, 'y': @_y }

  @id: ->
    @_id++