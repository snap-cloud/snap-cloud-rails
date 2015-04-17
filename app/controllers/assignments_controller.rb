class AssignmentsController < ApplicationController
	before_filter :userLoggedIn
	before_filter :courseExists, :only => [:new, :create]
	before_filter :assignmentExists, :only => [:show, :edit, :update, :delete]
	before_filter :authCourseEdit, :except => [:show]

	def show
		@assignment = Assignment.find_by(id: params[:id])
	end

	def new
		#render the page to create new assignment
	end

	def create
		@assignment = Assignment.new(assignment_params)
		if @assignment.valid?
			@course.assignments << @assignment
      flash[:message] = "You have created this assignment"
      redirect_to assignment_show_path(@assignment) and return
    else
    	render 'new'
    	return
		end
	end

	def edit
		#render the edit page. :assignmentExists should populate @assignment
	end

	def update
		@update = Assignment.new(assignment_params)
		if @update.valid?
			Assignment.update(@assignment.id, assignment_params)
      flash[:message] = "You have edited this assignment"
      redirect_to assignment_show_path(@assignment) and return
    else
    	render 'edit'
    	return
		end
	end

	def delete
		@assignment.destroy
	end

	def getCurrentUser
		current_user
	end

	def assignment_params
    params.require(:assignment).permit(:title, :description, :start_date, :due_date)
  end

	def userLoggedIn
  	if getCurrentUser.nil?
    	render file: "#{Rails.root}/public/401.html", layout: false, status: 401 and return
    end
  end

  def courseExists
  	if !Course.exists?(params[:course_id])
    	render file: "#{Rails.root}/public/404.html", layout: false, status: 404 and return
    else
    	@course = Course.find(params[:course_id])
    end
  end

  def authCourseEdit
  	if params[:course_id]
  		@course = Course.find(params[:course_id])
  	else
  		@assignment = Assignment.find(params[:id])
  		@course = Course.find(@assignment.course)
  	end
    if !@course.userRole(getCurrentUser).try(:teacher?)
      render file: "#{Rails.root}/public/401.html", layout: false, status: 401 and return
    end
  end

  def assignmentExists
  	if !Assignment.exists?(params[:id])
    	render file: "#{Rails.root}/public/404.html", layout: false, status: 404 and return
    else
    	@assignment = Assignment.find(params[:id])
    end
  end
end
