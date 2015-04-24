

class CoursesController < ApplicationController
    before_filter :userLoggedIn, :except => [:index, :show]
    before_filter :courseExists, :except => [:new, :create, :index]
    before_filter :authCourseEdit, :only => [:update, :delete, :edit]

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
      render 'new'
      return
    end
    #form on the new page gets submitted here
  end

  def show
    @assignments = @course.assignments
    @user = getCurrentUser
    #Find the course with the give id
  end

  def update
    dropUsers
    incorrectEmails = addUsers
    if !incorrectEmails.empty?
      flash[:message] = incorrectEmails
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

  # def getCurrentUser
  #   current_user
  # end

  # def userLoggedIn
  #   if getCurrentUser.nil?
  #       redirect_to login_path and return
  #   else
  #     @user = getCurrentUser
  #   end
  # end

  # def courseExists
  #   if !Course.exists?(params[:id])
  #     render file: "#{Rails.root}/public/404.html", layout: false, status: 404 and return
  #   else
  #     @course = Course.find(params[:id])
  #   end
  # end

  # def authCourseEdit
  #   if !@course.userRole(getCurrentUser).try(:teacher?)
  #     render file: "#{Rails.root}/public/401.html", layout: false, status: 401 and return
  #   end
  # end

  private

  def dropUsers
    drops = params[:drops]
    if drops
      drops.each_key do |email|
        drop = User.find_by(email: email)
        @course.removeUser(drop)
      end
    end
  end

  def addUsers
    incorrectEmails = ""
    adds = params[:adds]
    addField = params[:add_field]
    emails = []
    if adds then emails += adds.values end
    if addField then emails << addField.to_s end
    emails.each do |email|
      addUser = User.find_by(email: email)
      if !addUser.nil?
        @course.addUser(addUser, :student)
      elsif !email.nil? && !email.empty?
        incorrectEmails += "Email could not be found: " + email + "\n"
      end
    end
    return incorrectEmails
  end
  
end
