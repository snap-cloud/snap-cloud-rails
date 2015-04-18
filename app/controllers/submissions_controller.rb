class SubmissionsController < ApplicationController
    def new
        @user = current_user
        @assignment = Assignment.find_by(params[:assignment_id])
    end
end
