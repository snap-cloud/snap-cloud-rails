class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def show
    if not User.exists?(params[:id])
      # TODO: render 404 and gtfo
    end
    @user = User.find(params[:id])
    @projects = Project.where("owner = ?", params[:id])
    render :action => "show"
  end

  def edit
    # Do users even edit themselves this way?
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
  end
end
