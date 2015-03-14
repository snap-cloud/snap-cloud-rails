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
    project = Project.find(params[:id])

    if project.update(project_params)
      render json: project, status: 200, location: [:api, project]
    else
      render json: { errors: project.errors }, status: 422
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    head 204
  end

  private

    def project_params
      params.require(:project).permit(:title, :notes, :thumbnail, :contents, 
        :is_public, :owner, :last_modified, :created_at, :updated_at)
    end
end