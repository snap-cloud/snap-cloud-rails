class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # FIXME --- we should fix this.
  # skip_before_filter :verify_authenticity_token

  protect_from_forgery with: :exception => :create
end
