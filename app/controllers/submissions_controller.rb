class SubmissionsController < ApplicationController
  before_filter :userLoggedIn
  before_filter :assignmentExists
  before_filter :canSubmit

    def create
      @submission = submission_params
      @assignment.submit(@submission[:project_id], @submission[:comments])
      flash[:message] = "Yay, your project was submitted!"
      redirect_to assignment_show_path @assignment.id && return
    end

    def submission_params
      params.require(:submission).permit(:project_id, :comments)
    end

    def userLoggedIn
      if getCurrentUser.nil?
        redirect_to login_path && return
      else
        @user = getCurrentUser
      end
    end

    def assignmentExists
      if !Assignment.exists?(params[:assignment_id])
        item_not_found
      else
        @assignment = Assignment.find(params[:assignment_id])
      end
    end

    def canSubmit
      course = @assignment.course
      if not course.student_ids.include? @user.id
        access_denied
      end
    end

    def getCurrentUser
      current_user
    end

end
