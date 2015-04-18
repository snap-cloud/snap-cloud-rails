class Api::V1::ProjectsController < ProjectsController
  before_action :find_project, only: [:index]
  respond_to :json

  # FIXME -- this method needs auth checking as well.`
  def show
    respond_with Project.find(params[:id])
  end

  # returns all projects if user is looking at own projects
  # returns public projects for users if otherwise
  def index
    # find_project
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
  end

  def create
    project = Project.new({})
    project.save
    render :nothing => true, status: 200
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

end
