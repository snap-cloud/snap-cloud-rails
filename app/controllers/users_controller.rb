class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def profile
    if params[:id]
      @user = User.find(params[:id])
      @about_me = @user.about_me || "Enter information about you and your interests here."
    else
      redirect_to "/"
    end
  end

  def show
    @user = User.find(params[:id])

    # where returns an active record relation with all of a user's projects
    # .each turns the result into an enumerable
    @projects = Project.where("owner = ?", params[:id])
  end

  def edit
    # Do users even edit themselves this way?
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
  end

end
