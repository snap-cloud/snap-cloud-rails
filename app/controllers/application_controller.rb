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
  def access_denied # Equivalent 401
    raise SnapException::AccessDenied.new('You don\'t have permission to view this.')
  end
  
  def item_not_found # Equivalent 404
    raise ActiveRecord::RecordNotFound.new('Not Found')
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

    def getCurrentUser
      current_user
    end

    def userLoggedIn
      if getCurrentUser.nil?
          redirect_to login_path and return
      else
        @user = getCurrentUser
      end
    end

    def courseExists
      if params[:course_id]
        @course = Course.find(params[:course_id])
      elsif params[:assignment_id]
        @assignment = Assignment.find(params[:assignment_id])
        @course = Course.find(@assignment.course.id)
      end
    end

    def authCourseEdit
      if !@course.userRole(getCurrentUser).try(:teacher?)
        render file: "#{Rails.root}/public/401.html", layout: false, status: 401 and return
      end
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
