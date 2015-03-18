class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # This is for JSON APIs
  protect_from_forgery with: :null_session, :if => Proc.new {
    |c| c.request.format == 'application/json' }

  # for session tokens
  acts_as_token_authentication_handler_for User

  # Modify th native render to always check for JSONP callbacks
  # FIXME == this should only modify JSON formatted renders or /api/
  def render(options = nil, deprecated_status = nil, &block)
    if params && params[:callback]
      options[:callback] = params[:callback]
    end

    # Set CORS headers here...
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    remove_keys = %w(X-Frame-Options)
    response.headers.delete_if{|key| remove_keys.include? key}

    # call the ActionController::Base render to show the page
    super
  end
  # protect_from_forgery with: :exception
end
