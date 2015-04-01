class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end


  def show
    if not Project.exists?(params[:id])
      # TODO: render 404 and gtfo
    end
    @project = Project.find(params[:id])
    render :action => "show"
  end

  def update
  end

  def destroy
    proj = Project.find(params[:id])
    proj.destroy
  end

end
