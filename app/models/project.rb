class Project < ActiveRecord::Base
  # skip_before_filter :verify_authenticity_token

  belongs_to :user, :foreign_key => :owner

end
