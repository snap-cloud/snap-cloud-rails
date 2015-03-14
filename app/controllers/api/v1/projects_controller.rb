class Api::V1::ProjectsController < ApplicationController
  respond_to :json

  def show
    respond_with Project.find(params[:id])
  end

  # returns all projects if user is looking at own projects
  # returns public projects for users if otherwise
  def index
    if !current_user.nil? && current_user.id == params[:user_id]
      respond_with Project.where(owner: params[:user_id])
    else
      respond_with Project.where(owner: params[:user_id], is_public: 1)
    end
    debugger
  end

  def create
    project = Project.new(project_params)
    if project.save
      render json: project, status: 201, location: [:api, project]
    else
      render json: { errors: project.errors }, status: 422
    end
  end


  def update
    if self.getCurrentUser
        project = Project.find_by_id(params[:id])
      if project
        if project.owner == self.getCurrentUser.id
          project.update_attributes(params[:project_params])
          project.save
          render :nothing => true, :status => :no_content
        else
          render :nothing => true, :status => :unauthorized
        end
      else
        render :nothing => true, :status => :not_found
      end
    else
      render :nothing => true, :status => :unauthorized
    end
  end


  def destroy
    project = Project.find(params[:id])
    project.destroy
    head 204
  end

  def getCurrentUser
    return current_user
  end


  private

    def project_params
      params.require(:project).permit(:title, :notes, :thumbnail, :contents, 
        :is_public, :owner, :last_modified, :created_at, :updated_at)
    end


end
