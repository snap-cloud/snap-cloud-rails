class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end


  def show
    if not Project.exists?(params[:id])
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end
    @project = Project.find(params[:id])
    @owner = User.find_by_id @project.owner
    render :action => "show"
  end

  def edit
    # TODO: implement this -- don't forget to see if the user is an owner before actually letting them edit!
  end

  def destroy
    proj = Project.find(params[:id])
    proj.destroy
  end

end
