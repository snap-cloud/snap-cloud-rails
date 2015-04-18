class ProjectsController < ApplicationController
  before_action :find_project

  def new
    @project = Project.new
  end


  def index
    if @project
      render :action => "show"
    end
    
  end
  
  def show
    # @project = find_project()
    if @project != nil
      @project = Project.find(params[:id])
      @owner = User.find_by_id @project.owner
      render :action => "show"
    end
  end

  def edit
    # TODO: don't forget to see if the user is an owner before actually letting them edit!
    # @project = find_project()
    if @project != nil
      @owner = User.find_by_id @project.owner

      if not (current_user && @owner == current_user)
        render file: "#{Rails.root}/public/401.html", layout: false, status: 401
        return
      end

      render :action => "edit"
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def update
    # @project = find_project()
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
      puts 'find find find'
      if params[:username] && params[:projectname]
        find_project_by_name(params[:username], params[:projectname])
      elsif not Project.exists?(params[:id])
        render status: 404
        # render file: "/public/404.html", layout: false, status: 404
        return
      else
        @project = Project.find(params[:id])
      end
    end

    def project_params
      # FIXME -- verify with API controller?
      params.require(:project).permit(:title, :notes, :is_public, :contents)
    end

    def find_project_by_name(username, projectname)
      # NOTE: This method needs serious consideration about how to handle
      # projects that can't be found, and ones that are explicitly private
      # 401 reveals that a project does at least exist...is this a problem?
      # TODO: Handle multiple ownership
      @owner = User.find_by(username: username)
      if @owner == nil
        # FIXME -- add notice username not found
        render status: 404 # FIXME - 401?
      end
      owner_id = @owner.id
      @project = Project.find_by(owner: owner_id, title: projectname)
      debugger
      if @project == nil
        render status: 404 # FIXME -- 401? Project could be private
        return
      end
      if !@project.is_public && @project.owner != self.getCurrentUser.id
        # Project Is private
        render status: 404
      end
      # @project = project
      # respond_with project
    end
end
