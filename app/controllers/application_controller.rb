class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  # for session tokens
  # acts_as_token_authentication_handler_for User

  before_action :configure_permitted_parameters, if: :devise_controller?


  # Custom Error Methos
  module SnapException
    class AccessDenied < StandardError; end
  end

  # Clean Error Handler Methods
  # Use these in place of handling errors individually.
  def access_denied(msg = nil)  # Equivalent 401
    default = 'You don\'t have permission to view this.'
    msg = msg || default
    raise SnapException::AccessDenied.new(msg)
  end

  def item_not_found(msg = nil) # Equivalent 404
    default = 'This is Could Not Be Found'
    msg = msg || default
    raise ActiveRecord::RecordNotFound.new(msg)
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # Treat 401s as 404s for privacy concerns
  rescue_from SnapException::AccessDenied, :with => :record_not_found


  protected

    def configure_permitted_parameters
      # FIXME == birthday and TOS agree?
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end

  private
    def record_not_found(error)
      respond_to do |format|
        format.html {
          # TODO: Render specific error message somewhere?
          render file: "pages/_404.html", layout: true, status: 404
        }
        format.json {
          render json: {:error => error.message}, status: 404
        }
      end
    end
end
