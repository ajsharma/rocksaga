root = exports ? this # root and window are same thing in browser
root.Game ?= {}
$ = jQuery

$ -> 
  board = new Game.Board();
  board.start();