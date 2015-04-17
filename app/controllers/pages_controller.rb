class PagesController < ApplicationController

  def index
    @user =  current_user
    if @user
      @projects = Project.where("owner = ?", @user.id)
      @announcements = Announcement.all
      @courses = @user.courses
      @assignments = @user.assignments
      render 'dashboard' 
    else
      @projects = Project.where(:is_public => true).take(1)
      render 'index'
    end
  end

  def about
    render 'about'
  end

  def help
    render 'help'
  end
  
end
