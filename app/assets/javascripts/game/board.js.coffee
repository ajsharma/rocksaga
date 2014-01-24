root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.Board
  _rocks: []

  constructor: ->
    @_element = $('[data-board]').first()
    @_element.empty()

  start: ->
    @populate()
    # TODO: set listeners

  populate: ->
    for x in [0..7]
      rowElement = @createRowElement()
      @_element.append(rowElement)
      for y in [0..7]
        rock = new Game.Rock(x, y)
        @_rocks.push(rock)
        rowElement.append(rock.div)

  createRowElement: ->
    $('<ul />', {
      'class': 'small-block-grid-8',
      'data-board-row': 'data-board-row'
    })