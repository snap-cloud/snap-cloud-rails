class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # FIXME --- we should fix this.
  # skip_before_filter :verify_authenticity_token

  # This is for JSON APIs
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  # for session tokens
  acts_as_token_authentication_handler_for User

  # turn off csrf protection for json
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
end
