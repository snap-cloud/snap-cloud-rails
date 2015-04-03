class CoursesController < ApplicationController
  def create
    user = getCurrentUser
    @course = Course.new(course_params)
    if @course.valid?
      @course.save
      flash[:message] = "You have created this course"
      @course.addUser(user, :teacher)
      redirect_to course_show_path(@course.id)
      return
    else
      flash[:message] = "Fields invalid"
      render 'new'
      return
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
      redirect_to course_index_path
      return
    else
      flash[:message] = "You do not have permission to delete this course"
      redirect_to course_path(@course)
      return
    end

  end

  def new
    user = getCurrentUser
    if user.nil?
      flash[:message] = "Log in to create a course"
      redirect_to course_index_path
      return
    end
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
