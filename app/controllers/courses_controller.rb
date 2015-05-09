class CoursesController < ApplicationController
  before_filter :userLoggedIn, except: [:index, :show]
  before_filter :courseExists, except: [:new, :create, :index]
  before_filter :authCourseEdit, only: [:update, :delete, :edit]

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
      render 'new' and return
    end
    # form on the new page gets submitted here
  end

  def show
    @assignments = @course.assignments
    @user = getCurrentUser
    #Find the course with the give id
  end

  def update
    dropUsers
    incorrectNames = addUsers
    if !incorrectNames.empty?
      flash[:message] = incorrectNames
    end
    redirect_to course_edit_path(@course)
    #form on the edit page submitted here
  end

  def delete
    @course.destroy
    flash[:message] = "Course has been deleted"
    redirect_to course_index_path and return
  end

  def new
    #render a view so the user has a form to submit
  end

  def index
    #find all courses
    @courses = Course.all
  end

  def edit
    @students = @course.students
  end

  def course_params
    params.require(:course).permit(:title, :website, :description, :startdate, :enddate)
  end

  private

  def dropUsers
    drops = params[:drops]
    if drops
      # FIXME: Can't we combine this into on DB access?
      drops.each_key do |username|
        drop = User.find_by(username: username)
        @course.removeUser(drop)
      end
    end
  end

  def parseNames
    adds = params[:adds]
    addField = params[:add_field]
    names = []
    if adds then names += adds.values end
    if addField then names << addField.to_s end
    names.reject!(&:empty?)
    return names
  end

  def addUsers
    incorrectNames = ""
    names = parseNames
    names.each do |name|
      addUser = User.find_by(username: name)
      if !addUser.nil?
        @course.addUser(addUser, :student)
      else
        incorrectNames += "Username could not be found: " + name + "\n"
      end
    end
    return incorrectNames
  end

end
