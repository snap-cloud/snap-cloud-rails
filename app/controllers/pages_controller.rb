class PagesController < ApplicationController

  def index
  	if current_user
  		@user =  current_user
  		@projects = Project.where("owner = ?", current_user.id)
  		render 'dashboard' 
  	else
  		render 'index'
  	end
  end

end
