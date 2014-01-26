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
            rock = new Game.Rock(@, x, y)
            @_rocks[x][y] = rock
            break unless @isInChain(x, y) # boo for breaks, but no do...while in CoffeeScript

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
      @swapWithSelected(rock)
      return true 
    else
      return false

  isAdjacentToSelected: (rock) ->
    if rock.x() == @_selectedRock.x()
      return (rock.y() == (@_selectedRock.y() - 1)) || (rock.y() == (@_selectedRock.y() + 1))
    else if rock.y() == @_selectedRock.y()
      return (rock.x() == (@_selectedRock.x() - 1)) || (rock.x() == (@_selectedRock.x() + 1))

    return false

  isVerticalChain: (x, y) ->
    return (@upwardVerticalChainLength(x, y) + @downwardVerticalChainLength(x, y)) >= 3

  upwardVerticalChainLength: (x, y) ->
    unless @_rocks[x][y]?
      return false

    chainLength = 1
    row = x

    while(row > 0 && @_rocks[row - 1][y]? && (@_rocks[row - 1][y].type() == @_rocks[x][y].type()))
      chainLength++
      row--

    return chainLength

  downwardVerticalChainLength: (x, y) ->
    unless @_rocks[x][y]?
      return false

    chainLength = 1
    row = x

    while(row < 7 && @_rocks[row + 1][y]? && (@_rocks[row + 1][y].type() == @_rocks[x][y].type()))
      chainLength++
      row++

    return chainLength

  isHorizontalChain: (x, y) ->
    return (@leftwardHorizontalChainLength(x, y) + @rightwardHorizontalChainLength(x, y)) >= 3

  leftwardHorizontalChainLength: (x, y) ->
    unless @_rocks[x][y]?
      return 0

    chainLength = 1
    column = y

    while(column > 0 && @_rocks[x][column - 1]? && (@_rocks[x][column - 1].type() == @_rocks[x][y].type()))
      chainLength++
      column--

    return chainLength

  rightwardHorizontalChainLength: (x, y) ->
    unless @_rocks[x][y]?
      return 0

    chainLength = 1
    column = y

    column = y
    while(column < 7 && @_rocks[x][column + 1]? && (@_rocks[x][column + 1].type() == @_rocks[x][y].type()))
      chainLength++
      column++

    return chainLength

  isInChain: (x, y) ->
    return @isVerticalChain(x, y) || @isHorizontalChain(x, y)

  swapWithSelected: (rock) ->
    if @_selectedRock?
      temp = @_selectedRock
      @_rocks[@_selectedRock.x()][@_selectedRock.y()] = rock
      @_rocks[rock.x()][rock.y()] = @_selectedRock


