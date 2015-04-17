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
      render 'new'
      return
    end
    #form on the new page gets submitted here
  end

  def show
    @course = courseExists?("The course you're trying to view does not exist")
    @assignments = @course.assignments
    #Find the course with the give id
  end

  def update
=begin
    @course = courseExists?("The course you're trying to update does not exist")
    if !@course
      return
    end
    if !userLoggedIn?("You must be logged in to edit a course")
      return
    end
    if !@course.userRole(getCurrentUser).try(:teacher?)
      flash[:message] = "You do not have permission to edit this course"
    end
=end
    if !editable?
      return
    end
    drops = params[:drops]
    if drops
      drops.each_key do |email|
        drop = User.find_by(email: email)
        @course.removeUser(drop)
      end
    end
    incorrectEmails = ""
    adds = params[:adds]
    if adds
      adds.each do |key, email|
        addUser = User.find_by(email: email)
        #byebug
        if !addUser.nil?
          @course.addUser(addUser, :student)
        elsif !email.nil? && !email.empty?
          incorrectEmails += "Email could not be found: " + email + "\n"
        end
      end
    end
    addField = params[:add_field]
    if addField
      addUser = User.find_by(email: addField)
      #byebug
      if !addUser.nil?
        @course.addUser(addUser, :student)
      elsif !addField.nil? && !addField.empty?
        incorrectEmails += "Email could not be found: " + addField + "\n"
      end
    end
    if !incorrectEmails.empty?
      flash[:message] = incorrectEmails
    end
    redirect_to course_edit_path(@course)
    #form on the edit page submitted here
  end

  def delete
=begin
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
      redirect_to course_index_path and return
    else
      flash[:message] = "You do not have permission to delete this course"
      redirect_to course_show_path(@course) and return
    end
=end
    if !editable?
      return
    else
      @course.destroy
      flash[:message] = "Course has been deleted"
      redirect_to course_index_path and return
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
=begin
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
=end
  if !editable?
    return
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

  def editable?
    @course = courseExists?("This course does not exist")
    if !@course
      return false
    end

    if not userLoggedIn?("You must log in to edit or delete courses")
      return false
    end
    
    if !@course.userRole(getCurrentUser).try(:teacher?)
      flash[:message] = "You do not have permission to edit or delete this course"
      redirect_to course_show_path(@course) and return false
    end
    return true
  end

end
