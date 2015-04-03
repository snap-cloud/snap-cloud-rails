class PagesController < ApplicationController

  def index
    @user =  current_user
    if @user
      @projects = Project.where("owner = ?", @user.id)
      render 'dashboard' 
    else
      render 'index'
    end
  end
  
end
