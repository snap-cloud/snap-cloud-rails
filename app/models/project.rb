class Project < ActiveRecord::Base
  attr_accessible :title, :owner, :project_id, :date_created, :last_modified
end
