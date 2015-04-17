class AssignmentsController < ApplicationController

    def show
        @assignment = Assignment.find_by(params[:id])
    end

    
    
end
