class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format == 'application/json' }

  # for session tokens
  # acts_as_token_authentication_handler_for User

  before_action :configure_permitted_parameters, if: :devise_controller?


  # Custom Error Methods
  # These are app level errors that we can use to configure how to handle them
  # They should be created when there is not an already applicable Rails error
  # TODO: We need to determine for the best split up 401 and 404 errors.
  module SnapException
    class AccessDenied < StandardError; end
  end

  def access_denied(msg='You don\'t have permission to view this item.')
    raise SnapException::AccessDenied.new(msg)
  end

  def item_not_found(msg="This item couldn't be found.")
    raise ActiveRecord::RecordNotFound.new(msg)
  end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # Treat 401s as 404s for privacy concerns
  rescue_from SnapException::AccessDenied, with: :record_not_found
  # This would handle all errors....
  # rescue_from StandardError, with: :error_render_method

  protected

  # FIXME == birthday and TOS agree?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
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
      if !@course.userRole(current_user).try(:teacher?)
        access_denied
      end
    end

    def assignmentExists
      if !Assignment.exists?(id: params[:assignment_id])
        item_not_found
      else
        @assignment = Assignment.find(params[:assignment_id])
      end
    end

    def partOfCourse
      if @assignment.course.userRole(@user).nil?
        access_denied
      end
    end

  private

  def record_not_found(error)
    respond_to do |format|
      format.html {
        render "pages/_404.html", layout: true, status: 404
      }
      format.json {
        render json: {error: error.message}, status: 404
      }
    end
  end
end
