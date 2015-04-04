class User < ActiveRecord::Base
  # use simple_token_authentication on users
  acts_as_token_authenticatable

  validates_length_of :about_me, :maximum => 500, :allow_blank => true

  # A user has many projects, and deleting user deletes projects of that user
  # FIXME -- how do we handle projects with multiple owners?
  has_many :projects, dependent: :destroy
  has_many :enrollments

  def projects
    Project.where(:owner => self.id).all
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_attached_file :avatar,
  :default_url => "default_avatar.jpg",
  :storage => :s3,
  :bucket => 'snap-cloud',
  :s3_credentials => {
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  },
  :styles => {
    :thumb    => ['100x100#',  :jpg, :quality => 70],
    :preview  => ['480x480#',  :jpg, :quality => 70],
    :large    => ['600>',      :jpg, :quality => 70],
    :retina   => ['1200>',     :jpg, :quality => 30]
  },
  :convert_options => {
    :thumb    => '-set colorspace sRGB -strip',
    :preview  => '-set colorspace sRGB -strip',
    :large    => '-set colorspace sRGB -strip',
    :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
  }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
