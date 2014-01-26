root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.Board
  _rocks: []
  _selectedX: null
  _selectedY: null
  _selectedRock: null
  _states = [
    'pick'
  ]

  state: 'populate'

  constructor: ->
    @_element = $('[data-board]').first()
    @_element.empty()
    for x in [0..7]
      @_rocks[x] = [0..7]
      for y in [0..7]
        @_rocks[x][y] = null

  start: ->
    @populate()
    @state = 'pick'
    # TODO: set listeners

  populate: ->
    rowElement = @createRowsElement()
    @_element.append(rowElement)
    for x in [0..7]
      for y in [0..7]
        unless @_rocks[x][y]?
          while true
            console.log "set #{x}, #{y}"
            rock = new Game.Rock(@, x, y)
            @_rocks[x][y] = rock
            break unless @isSequence(x, y) # boo for breaks, but no do...while in CoffeeScript

          # TODO: move DOM manipulation elsewhere
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

  select: (rock) ->
    if @_selectedRock == rock
      @_selectedRock = null
      return true
    else if !(@_selectedRock?)
      @_selectedRock = rock
      return true
    else if @isAdjacentToSelected(rock)
      # TODO: swap
      return true 
    else
      return false

  isAdjacentToSelected: (rock) ->
    if rock.x() == @_selectedRock.x()
      return (rock.y() == (@_selectedRock.y() - 1)) || (rock.y() == (@_selectedRock.y() + 1))
    else if rock.y() == @_selectedRock.y()
      return (rock.x() == (@_selectedRock.x() - 1)) || (rock.x() == (@_selectedRock.x() + 1))

    return false

  isVerticalSequence: (x, y) ->
    return (@upwardVerticalSequenceLength(x, y) + @downwardVerticalSequenceLength(x, y)) >= 3

  upwardVerticalSequenceLength: (x, y) ->
    unless @_rocks[x][y]?
      return false

    sequenceLength = 1
    row = x

    while(row > 0 && @_rocks[row - 1][y]? && (@_rocks[row - 1][y].type() == @_rocks[x][y].type()))
      sequenceLength++
      row--

    return sequenceLength

  downwardVerticalSequenceLength: (x, y) ->
    unless @_rocks[x][y]?
      return false

    sequenceLength = 1
    row = x

    while(row < 7 && @_rocks[row + 1][y]? && (@_rocks[row + 1][y].type() == @_rocks[x][y].type()))
      sequenceLength++
      row++

    return sequenceLength

  isHorizontalSequence: (x, y) ->
    return (@leftwardHorizontalSequenceLength(x, y) + @rightwardHorizontalSequenceLength(x, y)) >= 3

  leftwardHorizontalSequenceLength: (x, y) ->
    unless @_rocks[x][y]?
      return 0

    sequenceLength = 1
    column = y

    while(column > 0 && @_rocks[x][column - 1]? && (@_rocks[x][column - 1].type() == @_rocks[x][y].type()))
      sequenceLength++
      column--

    return sequenceLength

  rightwardHorizontalSequenceLength: (x, y) ->
    unless @_rocks[x][y]?
      return 0

    sequenceLength = 1
    column = y

    column = y
    while(column < 7 && @_rocks[x][column + 1]? && (@_rocks[x][column + 1].type() == @_rocks[x][y].type()))
      sequenceLength++
      column++

    return sequenceLength

  isSequence: (x, y) ->
    return @isVerticalSequence(x, y) || @isHorizontalSequence(x, y)

  swap: (x, y) ->

