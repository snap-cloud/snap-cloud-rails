class AssignmentsController < ApplicationController
  before_filter :userLoggedIn
  before_filter :courseExists, only: [:new, :create]
  before_filter :assignmentExists, only: [:show, :edit, :update, :delete]
  before_filter :partOfCourse, only: [:show]
  before_filter :authCourseEdit, except: [:show]

  def show
    @assignment = Assignment.find_by(id: params[:assignment_id])
  end

  def new
    # render the page to create new assignment
    @course = Course.find(params[:course_id])
  end

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.valid?
      @course.assignments << @assignment
      flash[:message] = "You have created this assignment"
      redirect_to assignment_show_path(@assignment) && return
    else
      render "new" && return
    end
  end

  def edit
    # render the edit page. :assignmentExists should populate @assignment
    @assignment = Assignment.find(params[:assignment_id])
    @course = @assignment.course
  end

  def update
    @update = Assignment.new(assignment_params)
    if @update.valid?
      Assignment.update(@assignment.id, assignment_params)
      flash[:message] = "You have edited this assignment"
      redirect_to assignment_show_path(@assignment) && return
    else
      render "edit" && return
    end
  end

  def delete
    flash[:message] = "Assignment has been deleted"
    @assignment.destroy
    redirect_to course_show_path @course.id
  end

  def assignment_params
    params.require(:assignment).permit(:title, :description, :start_date, :due_date)
  end
end
