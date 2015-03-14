class Api::V1::ProjectsController < ApplicationController
  respond_to :json

  def show
    respond_with Project.find(params[:id])
  end

  # returns all projects if user is looking at own projects
  # returns public projects for users if otherwise
  def index
    if !current_user.nil? && current_user.id == params[:id]
      respond_with Project.where(id: params[:id])
    else
      respond_with Project.where(id: params[:id], is_public: true)
    end
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
    if self.current_user
      project = Project.find(params[:id])
      if project
        if project.owner == current_user.id
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


  private

    def project_params
      params.require(:project).permit(:title, :notes, :thumbnail, :contents, 
        :is_public, :owner, :last_modified, :created_at, :updated_at)
    end
end