class Project < ActiveRecord::Base
  # skip_before_filter :verify_authenticity_token

  belongs_to :user

  attr_accessor :title, :notes, :thumbnail, :contents, :is_public
  attr_accessor :owner, :last_modified, :created_at, :updated_at

end
