class Api::V1::ProjectsController < ApplicationController
  before_action :find_project
  respond_to :json

  # FIXME -- this method needs auth checking as well.`
  def show
    respond_with Project.find(params[:id])
  end

  # returns all projects if user is looking at own projects
  # returns public projects for users if otherwise
  def index
    if @project
      respond_with @project
      return
    end
    if params[:user_id]
      begin
        id = Integer(params[:user_id])
      rescue
      end
      if !getCurrentUser.nil? && getCurrentUser.id == id
        respond_with Project.where(owner: id)
      else
        respond_with Project.where(owner: id, is_public: true)
      end
    end
    respond_with status: 404
  end

  def create
    project = Project.new({})
    project.save
    render :nothing => true, status: 200
    ## old code
    #render json: project, status: 201, location: [:api, project]


  end


  def update
    if self.getCurrentUser
        project = Project.find_by_id(params[:id])
      if project
        if project.owner == self.getCurrentUser.id
          project.update_attributes(params[:project_params])
          project.save
          render :nothing => true, status: 204 #:no_content
        else
          render :nothing => true, status: 401 #:unauthorized
        end
      else
        render :nothing => true, status: 404 #:not_found
      end
    else
      render :nothing => true, status: 401 #:unauthorized
    end
  end


  def destroy
    project = Project.find(params[:id])
    if project.owner == self.getCurrentUser.id
      project.destroy
      render :nothing => true, status: 200 #:ok
    else
      render :nothing => true, status: 401 #:unauthorized
    end
  end

  def getCurrentUser
    return current_user
  end

  def project_listing
    # TODO: actually write this method lol
    project = Project.find(params[:id])
  end


  private

    def project_params
      params.require(:project).permit(:title, :notes, :thumbnail, :contents,
        :is_public, :owner, :last_modified, :created_at, :updated_at)
    end
    
    def find_project_by_name(username, projectname)
      # NOTE: This method needs serious consideration about how to handle
      # projects that can't be found, and ones that are explicitly private
      # 401 reveals that a project does at least exist...is this a problem?
      # TODO: Handle multiple ownership
      @owner = User.find_by(username: username)
      if @owner == nil
        # FIXME -- add notice username not found
        respond_with status: 404 # FIXME - 401?
      end
      @project = Project.find_by(owner: @owner.id, title: projectname)
      if @project == nil
        respond_with status: 404 # FIXME -- 401? Project could be private
        return
      end
      if !@project.is_public && @project.owner != self.getCurrentUser.id
        # Project Is private
        respond_with status: 404
      end
      # @project = project
      # respond_with project
    end
      
    def find_project
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

end
