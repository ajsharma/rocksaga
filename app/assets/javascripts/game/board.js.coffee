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
    rowElement = @createRowsElement()
    @_element.append(rowElement)
    for x in [0..7]
      for y in [0..7]
        rock = new Game.Rock(x, y)
        @_rocks.push(rock)

        rowLiElement = @createRowElement()
        rowElement.append(rowLiElement)
        rowLiElement.append(rock.div)

  createRowsElement: ->
    $('<ul />', {
      'class': 'small-block-grid-8',
      'data-board-row': 'data-board-row'
    })

  createRowElement: ->
    $('<li />')