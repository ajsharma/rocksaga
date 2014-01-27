class GameController < ApplicationController
  def index
    @users = User.all
    @score = Score.new
  end
end
