class User < ActiveRecord::Base
  # use simple_token_authentication on users
  acts_as_token_authenticatable
  
  # Allow login via username or email.
  attr_accessor :login
  
  validates_length_of :about_me, maximum: 500, allow_blank: true

  # A user has many projects, and deleting user deletes projects of that user
  has_many :enrollments
  has_many :courses,  through: :enrollments
  has_many :projects, class_name: "Project", foreign_key: :owner

  # FIXME -- how do we handle projects with multiple owners?
  # def projects
  #   Project.where(owner: self.id).all
  # end

  def assignments
    self.courses.map(&:assignments).flatten
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
  default_url: "default_avatar.jpg",
  storage: :s3,
  bucket: 'snap-cloud',
  s3_credentials: {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  },
  styles: {
    :thumb    => ['100x100#',  :jpg, quality: 60],
    :preview  => ['480x480#',  :jpg, quality: 60],
    :large    => ['600>',      :jpg, quality: 60],
    :retina   => ['1200>',     :jpg, quality: 60]
  },
  convert_options: {
    :thumb    => '-set colorspace sRGB -strip',
    :preview  => '-set colorspace sRGB -strip',
    :large    => '-set colorspace sRGB -strip',
    :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
  }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  # Allow login via username or email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
  
  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }
    
end
