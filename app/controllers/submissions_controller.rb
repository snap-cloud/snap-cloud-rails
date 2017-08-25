class SubmissionsController < ApplicationController
 before_action :authenticate_user!
  before_filter :courseExists
  before_filter :assignmentExists
  before_filter :partOfCourse

    def create
      @submission = submission_params
      @assignment.submit(@submission[:project_id], @submission[:comments])
      flash[:message] = "Yay, your project was submitted!"
      redirect_to assignment_show_path @assignment.id and return
    end

    def submission_params
      params.require(:submission).permit(:project_id, :comments)
    end

end
