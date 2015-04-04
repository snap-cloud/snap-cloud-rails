class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def profile
    if params[:id]
      @user = User.find(params[:id])
      @about_me = @user.about_me || "Enter information about you and your interests here."
      @projects = @user.projects
      @owner = @user == current_user
      if not @owner
        @projects = @projects.where(:is_public => true)
      end
    else
      redirect_to "/"
    end
  end

  def update
    if params[:id]
      @user = User.find(params[:id])
      @user.update(user_params)
      @user.save
    end
    redirect_to user_profile_path(params[:id])
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

  def user_params
    params.require(:user).permit(:avatar, :id, :about_me)
  end

end
