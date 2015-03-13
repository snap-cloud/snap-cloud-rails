class Project < ActiveRecord::Base
  # skip_before_filter :verify_authenticity_token

  ### LL : attr_accessible not supported in Rails 4.4.1; 
  ### 	   so you use "strong parameters" instead; 
  ###      see method user_params in projects_controller.rb
  #attr_accessible :title, :notes, :thumbnail, :contents, :is_public, :owner, 
  #:last_modified, :created_at, :updated_at
  
end
