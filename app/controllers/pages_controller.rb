class PagesController < ApplicationController

  def index
    @user =  current_user
    if @user
      @projects = Project.where("owner = ?", @user.id)
      @announcements = Announcement.all
      render 'dashboard' 
    else
      render 'index'
    end
  end
  
end
