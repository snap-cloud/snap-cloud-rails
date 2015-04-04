class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  # This is for JSON APIs
  # protect_from_forgery with: :null_session
  #, :if => Proc.new { |c| c.request.format == 'application/json' }

  # for session tokens
  # acts_as_token_authentication_handler_for User

  # protect_from_forgery with: :exception
end
