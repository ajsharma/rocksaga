root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

class Game.ScoreBoard
  _game: null
  _element: null
  _scoreInputElement: null

  constructor: (game, score) ->
    @_game = game
    @createElement(game, score)

  setScore: (score) ->
    @_scoreInputElement.val(score)

  createElement: (game, score) ->
    @_element = $('[data-scoreboard]').first()
    @_scoreInputElement = @_element.find("input[name='score[score]']").first()
    @_scoreInputElement.val(score)