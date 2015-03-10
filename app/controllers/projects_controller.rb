class ApplicationController < ApplicationController
  
  def new
  	raise NotImplementedError
  end
  
  #Linda: do we need both  new and create? .. 
  def create 
  	raise NotImplementedError
  end

  #Linda: show a project's details--like a project page
  def show 
  	raise NotImplementedError
  end

  #Linda: page where you edit the project
  def edit 
  	raise NotImplementedError
  end

  def delete
  	raise NotImplementedError
  end 

  #Linda: show list of all projects
  def index 
  	raise NotImplementedError
  end

    def sort_by_title
  	raise NotImplementedError
  end

  def sort_by_recent
  	raise NotImplementedError
  end

  #Linda: show projects only shared with me, or only my projects, or both.
  #think rotten-potatoes ratings-like feature here. Seems useful to have..
  def filter_by_shared
  	raise NotImplementedError
  end

end