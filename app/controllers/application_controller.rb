class ApplicationController < ActionController::Base
  include Authentication

  protect_from_forgery

  private

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end
