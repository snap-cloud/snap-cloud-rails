class CoursesController < ApplicationController
  def create
    if !userLoggedIn?("Log in to create a course")
      return
    end
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
    @course = courseExists?("The course you're trying to view does not exist")
    if !@course
      return
    end
    #Find the course with the give id
  end

  def update
    @course = courseExists?("The course you're trying to update does not exist")
    if !@course
      return
    end
    drops = params[drops]
    if drops
      drops.each_key do |email|
        dropUser = User.find_by(email)
        @course.removeUser(user)
      end
    end
    adds = params[adds]
    if adds
      adds.each do |key, email|
        addUser = User.find_by(email)
        @course.addUser(addUser, :student)
      end
    end
    #form on the edit page submitted here
  end

  def delete
    if !userLoggedIn?("Log in to delete this course")
      return
    end
    @course = courseExists?("The course you're trying to delete does not exist")
    if !@course
      return
    end
    if @course.userRole(getCurrentUser).try(:teacher?)
      @course.destroy
      flash[:message] = "Course has been deleted"
      redirect_to course_index_path
      return
    else
      flash[:message] = "You do not have permission to delete this course"
      redirect_to course_show_path(@course)
      return
    end

  end

  def new
    if !userLoggedIn?("Log in to create a course")
      return
    end
    #render a view so the user has a form to submit
  end

  def index
    #find all courses
    @courses = Course.all
  end

  def edit
    if !userLoggedIn?("You must be logged in to edit a course")
      return
    end
    @course = courseExists?("The course you're trying to edit does not exist")
    if !@course
      return
    end
    if !@course.userRole(getCurrentUser).try(:teacher?)
      flash[:message] = "You do not have permission to edit this course"
    end
    @students = @course.students
  end

  def course_params
    params.require(:course).permit(:title, :website, :description, :startdate, :enddate)
  end

  def getCurrentUser
    current_user
  end

  def userLoggedIn?(message)
    if getCurrentUser.nil?
        flash[:message] = message
        redirect_to course_index_path
        return false
    end
    true
  end

  def courseExists?(message)
    if !Course.exists?(params[:id])
      flash[:message] = message
      redirect_to course_index_path
      nil
    else
      Course.find(params[:id])
    end
  end

end
