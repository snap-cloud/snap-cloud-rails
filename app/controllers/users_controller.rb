class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def prettyname
    @user = User.find_by(username: params[:username])
    params[:id] = @user.try(:id)
    item_not_found unless params[:id]
    profile
    render 'profile'
  end

  def profile
    if params[:id]
      @user = User.find(params[:id])
      @about_me = @user.about_me || ""
      @projects = @user.projects
      @owner = @user == current_user
      if not @owner
        @projects = @projects.where(is_public: true)
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
    if params[:id]
      @user = User.find_by_id params[:id]
      if current_user && current_user == @user
        @about_me = @user.about_me || "Enter information about you and your interests here."
      else
        access_denied
      end
    else
      item_not_found
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
  end

  def user_params
    params.require(:user).permit(:avatar, :id, :about_me)
  end

end
