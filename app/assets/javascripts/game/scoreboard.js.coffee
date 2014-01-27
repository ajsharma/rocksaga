root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.ScoreBoard
  _game: null
  _element: null
  _inputElement: null

  constructor: (game, score) ->
    @_game = game
    @createElement(game, score)

  setScore: (score) ->
    $(@_inputElement).val(score)

  createElement: (game, score) ->
    @_element = $('[data-scoreboard]').first()
    @_inputElement = $("<input />", {
      'class': 'scoreboard'
      'data-scoreboard':'data-scoreboard'
    })
    $(@_inputElement).val(score)
    @_element.append(@_inputElement)
