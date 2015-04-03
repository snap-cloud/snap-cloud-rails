class CoursesController < ApplicationController
  def create
    user = getCurrentUser
    if !getCurrentUser
      flash[:error] = "Log in to create a course"
      redirect_to course_index
    end
    @course = Course.new(course_params)
    if @course.valid?
      @course.save
      flash[:message] = "You have created this course"
      @course.addUser(user, :teacher)
      redirect_to course(@course.id)
    else
      render 'new'
      flash[:error] = "Fields invalid"
    end
    #form on the new page gets submitted here
  end

  def show
    @course = Course.find(params[:id])
    #Find the course with the give id
  end

  def update
    #form on the edit page submitted here
  end

  def delete
    @course = Course.find(params[:id])
    if @course.userRole(getCurrentUser).teacher?
      @course.destroy
      flash[:message] = "Course has been deleted"
    else
      flash[:error] = "You do not have permission to delete this course"
    end
  end

  def new
    #render a view so the user has a form to submit
  end

  def index
    #find all courses
  end

  def edit
    #render a view so the user has a form to submit
  end

  def course_params
    params.require(:course).permit(:title, :website, :description, :startdate, :enddate)
  end

  def getCurrentUser
    current_user
  end

end
