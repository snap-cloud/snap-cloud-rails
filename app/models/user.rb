class User < ActiveRecord::Base
  # use simple_token_authentication on users
  acts_as_token_authenticatable

  validates_length_of :about_me, :maximum => 500, :allow_blank => true

  # A user has many projects, and deleting user deletes projects of that user
  # FIXME -- how do we handle projects with multiple owners?
  has_many :projects, dependent: :destroy
  has_many :enrollments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
end
