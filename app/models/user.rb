class User < ActiveRecord::Base
  # use simple_token_authentication on users
  acts_as_token_authenticatable

  # A user has many projects, and deleting user deletes projects of that user
  has_many :projects, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
end
