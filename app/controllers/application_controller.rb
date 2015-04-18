class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  # for session tokens
  # acts_as_token_authentication_handler_for User

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Clean Error Handler Methods
  # Use item_not_found in code, and we have a rescue method to properly handle
  # JSON or HTML based responses and can do any cleanup if need be.
  def item_not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end
  
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  

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
