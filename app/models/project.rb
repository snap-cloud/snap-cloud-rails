class Project < ActiveRecord::Base
  attr_accessible :title, :description, :owner, :shared_with, :project_id, :date_created, :last_modified
end
