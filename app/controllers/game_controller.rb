class GameController < ApplicationController
  def index
    @users = User.all
  end
end
