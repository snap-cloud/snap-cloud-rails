class Project < ActiveRecord::Base
  # skip_before_filter :verify_authenticity_token
  attr_accessible :title, :notes, :thumbnail, :contents, :is_public, :owner, 
  :last_modified, :created_at, :updated_at
end
