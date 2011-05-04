class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def authenticate
    user_signed_in?
  end
end
