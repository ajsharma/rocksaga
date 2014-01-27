root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.Board
  _rocks: []
  _score: 0
  _scoreBoard: null
  _selectedX: null
  _selectedY: null
  _selectedRock: null
  _states: [
    'pick'
    'populating'
  ]

  state: null

  constructor: ->
    @_element = $('[data-board]').first()
    @_element.empty()
    @setState('populating')
    for x in [0..7]
      @_rocks[x] = [0..7]
      for y in [0..7]
        @_rocks[x][y] = null
    @_scoreBoard = new Game.ScoreBoard(@, 0)

  start: ->
    @populate()
    @setState('pick');
    # TODO: set listeners

  setState: (state) ->
    if(state == 'populating')
      @_element.attr('disabled', 'disabled')
    
    @state = state

  populate: ->
    rowElement = @createRowsElement()
    @_element.append(rowElement)
    for x in [0..7]
      for y in [0..7]
        unless @_rocks[x][y]? && @_rocks[x][y].type()?
          while true
            rock = new Game.Rock(@, x, y)
            @_rocks[x][y] = rock
            break unless @isInChain(x, y) # boo for breaks, but no do...while in CoffeeScript

          # TODO: move DOM manipulation elsewhere
          rowLiElement = @createRowElement()
          rowElement.append(rowLiElement)
          rowLiElement.append(rock.element())

  repopulate: =>

    hasBlanks = false
    @setState('populating')  # TODO: disable board when populating
    for x in [7..0]
      for y in [7..0]
        if @_rocks[x][y]? && @_rocks[x][y].isBlank()
          if x - 1 >= 0 # rows pull down from above
            @_swapRocks(@_rocks[x][y], @_rocks[x - 1][y])
            hasBlanks = true
          else # top row needs new rocks
            rock = new Game.Rock(@, x, y)
            @_rocks[x][y].setType(rock.type())

    if hasBlanks
      # continuously repopulate until no blanks
      setTimeout @repopulate, 250
    else if @destroyRockChains()
      setTimeout @repopulate, 250
    else
      @setState('pick')

  dirtyRockChains: ->
    for x in [7..0]
      for y in [7..0]
        @_rocks[x][y]
        if @_rocks[x][y]? 
          @_rocks[x][y].setIsInChain(@isInChain(x, y))

  destroyRockChains: ->
    @dirtyRockChains()
      
    destroyedRockChains = false
    for x in [7..0]
      for y in [7..0]
        rock = @_rocks[x][y]
        if rock? && rock.isInChain()
          destroyedRockChains = true
          @incrementScore(1)
          rock.destroy()

    destroyedRockChains

  refresh: ->
    # Again, no do...while :(
    if @destroyRockChains()
      @repopulate()

  incrementScore: (increment) ->
    @_score = @_score + increment
    @_scoreBoard.setScore(@_score)

  selectedRock: ->
    @_selectedRock

  setSelectedRock: (rock) ->
    unless rock? 
      if @_selectedRock?
        @_selectedRock.clean()
      
    @_selectedRock = rock

  createRowsElement: ->
    $('<ul />', {
      'class': 'small-block-grid-8',
      'data-board-row': 'data-board-row'
    })

  createRowElement: ->
    $('<li />')

  isAdjacentToSelected: (rock) ->
    if rock.x() == @_selectedRock.x()
      return (rock.y() == (@_selectedRock.y() - 1)) || (rock.y() == (@_selectedRock.y() + 1))
    else if rock.y() == @_selectedRock.y()
      return (rock.x() == (@_selectedRock.x() - 1)) || (rock.x() == (@_selectedRock.x() + 1))

    return false

  isVerticalChain: (x, y) ->
    return (@upwardVerticalChainLength(x, y) + @downwardVerticalChainLength(x, y)) >= 2

  upwardVerticalChainLength: (x, y) ->
    unless @_rocks[x][y]? && @_rocks[x][y].isNotBlank()
      return false

    chainLength = 0
    row = x

    while(row > 0 && @_rocks[row - 1][y]? && (@_rocks[row - 1][y].type() == @_rocks[x][y].type()))
      chainLength++
      row--

    return chainLength

  downwardVerticalChainLength: (x, y) ->
    unless @_rocks[x][y]? && @_rocks[x][y].isNotBlank()
      return false

    chainLength = 0
    row = x

    while(row < 7 && @_rocks[row + 1][y]? && (@_rocks[row + 1][y].type() == @_rocks[x][y].type()))
      chainLength++
      row++

    return chainLength

  isHorizontalChain: (x, y) ->
    return (@leftwardHorizontalChainLength(x, y) + @rightwardHorizontalChainLength(x, y)) >= 2

  leftwardHorizontalChainLength: (x, y) ->
    unless @_rocks[x][y]? && @_rocks[x][y].isNotBlank()
      return 0

    chainLength = 0
    column = y

    while(column > 0 && @_rocks[x][column - 1]? && (@_rocks[x][column - 1].type() == @_rocks[x][y].type()))
      chainLength++
      column--

    return chainLength

  rightwardHorizontalChainLength: (x, y) ->
    unless @_rocks[x][y]? && @_rocks[x][y].isNotBlank()
      return 0

    chainLength = 0
    column = y

    column = y
    while(column < 7 && @_rocks[x][column + 1]? && (@_rocks[x][column + 1].type() == @_rocks[x][y].type()))
      chainLength++
      column++

    return chainLength

  isInChain: (x, y) ->
    return @isVerticalChain(x, y) || @isHorizontalChain(x, y)

  selectRock: (rock) ->
    unless @state == 'pick'
      return false

    if !(@_selectedRock?)
      @setSelectedRock(rock)
      return true
    else if @isAdjacentToSelected(rock)
      @swapWithSelected(rock)

    @setSelectedRock(null)

    return false

  swapWithSelected: (rock) ->
    swapped = false
    if @_selectedRock?
      @_swapRocks(@_selectedRock, rock)

      # determine if swapped rocks created any new chains
      selectedRockInChain = @isInChain(@_selectedRock.x(), @_selectedRock.y())
      rockInChain = @isInChain(rock.x(), rock.y())

      if selectedRockInChain || rockInChain
        @_selectedRock.clean()
        rock.clean()
        @setSelectedRock(null)

        @refresh()

        swapped = true
      else
        # invalid move, swap rocks back
        new Alert.Standard('Invalid move')
        @_swapRocks(@_selectedRock, rock)
      swapped

  _swapRocks: (firstRock, secondRock) ->
    firstType = firstRock.type()
    secondType = secondRock.type()
    firstRock.setType(secondType)
    secondRock.setType(firstType)