class Project < ActiveRecord::Base
  # skip_before_filter :verify_authenticity_token

  attr_accessor :title
  attr_accessor :notes
  attr_accessor :thumbnail
  attr_accessor :contents
  attr_accessor :is_public
  attr_accessor :owner
  attr_accessor :last_modified
  attr_accessor :created_at
  attr_accessor :updated_at

end
