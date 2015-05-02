class Project < ActiveRecord::Base
  # skip_before_filter :verify_authenticity_token

  belongs_to :user, :foreign_key => :owner

  has_attached_file :snap_file,
  :storage => :s3,
  :bucket => 'snap-cloud',
  :s3_credentials => {
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }

  validates_attachment_content_type :snap_file, :content_type => 'text/xml'

end
