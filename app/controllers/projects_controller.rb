class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end


  def show
    @project = find_project()
    if @project != nil
      @project = Project.find(params[:id])
      @owner = User.find_by_id @project.owner
      render :action => "show"
    end
  end

  def edit
    # TODO: don't forget to see if the user is an owner before actually letting them edit!
    @project = find_project()
    if @project != nil
      @owner = User.find_by_id @project.owner

      if not (current_user && @owner == current_user)
        render file: "#{Rails.root}/public/401.html", layout: false, status: 401
      end

      render :action => "edit"
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def update
    @project = find_project()
    if @project != nil
      @owner = User.find_by_id @project.owner
    end

    if @project.update_attributes(project_params)
      flash[:success] = "Project updated!"
      redirect_to @project
    else
      render :action => "edit"
    end
  end

  def destroy
    proj = Project.find(params[:id])
    proj.destroy
  end

  private

    def find_project
      if not Project.exists?(params[:id])
        render file: "#{Rails.root}/public/404.html", layout: false, status: 404
        return
      end
      return Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :notes, :is_public)
    end


end
