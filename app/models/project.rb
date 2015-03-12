class Project < ActiveRecord::Base
  attr_accessible :last_modified, :owner, :is_public, :contents, :thumbnail, :notes, :title,
end
