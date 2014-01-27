class GameController < ApplicationController
  def index
    @users = User.all
    @score = Score.new
    @top_score = Score.where_top.first
  end
end
